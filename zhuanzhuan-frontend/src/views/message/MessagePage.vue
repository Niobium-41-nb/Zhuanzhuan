<template>
  <div class="msg-page">
    <div class="msg-container">
      <!-- Sidebar -->
      <aside class="msg-side">
        <div class="side-head">
          <h2>消息</h2>
          <span v-if="totalUnread" class="unread-dot">{{ totalUnread }}</span>
        </div>
        <div class="side-search">
          <el-input v-model="searchText" placeholder="搜索会话..." size="small" clearable :prefix-icon="Search" />
        </div>
        <div class="side-list">
          <div v-for="c in filteredConvs" :key="c.userId"
            class="conv-row" :class="{ active: selectedUserId === c.userId }"
            @click="selectConversation(c)">
            <div class="conv-avatar">
              <el-avatar :size="44" :src="c.avatar">{{ c.nickname?.[0] }}</el-avatar>
              <span v-if="c.unreadCount" class="online-dot" />
            </div>
            <div class="conv-body">
              <div class="conv-line1">
                <span class="conv-name">{{ c.nickname }}</span>
                <span class="conv-time">{{ c.lastTime ? fmtTime(c.lastTime) : '' }}</span>
              </div>
              <div class="conv-line2">
                <span class="conv-preview">{{ c.lastMessage || '点击开始聊天' }}</span>
                <span v-if="c.unreadCount" class="conv-badge">{{ c.unreadCount }}</span>
              </div>
            </div>
          </div>
          <div v-if="!filteredConvs.length && !loading" class="side-empty">
            <span class="empty-icon">💬</span>
            <p>暂无消息</p>
            <span>去商品页联系卖家吧</span>
          </div>
        </div>
      </aside>

      <!-- Chat panel -->
      <section class="msg-main">
        <template v-if="selectedUserId">
          <header class="chat-top">
            <el-avatar :size="38" :src="selectedUser?.avatar">{{ selectedUser?.nickname?.[0] }}</el-avatar>
            <div class="chat-top-info">
              <strong>{{ selectedUser?.nickname || '用户'+selectedUserId }}</strong>
              <span v-if="selectedUser?.creditScore" class="credit">信誉 {{ selectedUser.creditScore }}分</span>
            </div>
          </header>
          <div class="chat-body" ref="msgBox">
            <div v-if="!messages.length" class="body-empty">
              <span class="empty-emoji">👋</span>
              <p>这是你们第一次聊天</p>
              <span>发送第一条消息开始交流</span>
            </div>
            <div v-for="(m,i) in messages" :key="m.id">
              <div v-if="showDateSep(i)" class="date-sep"><span>{{ fmtDate(m.createdAt) }}</span></div>
              <div class="bubble-row" :class="{ me: m.fromUserId === myId }">
                <el-avatar v-if="m.fromUserId !== myId" :size="30" :src="selectedUser?.avatar" class="bubble-avatar">{{ selectedUser?.nickname?.[0] }}</el-avatar>
                <div class="bubble-wrap">
                  <div class="bubble" :class="{ mine: m.fromUserId === myId }">{{ m.content }}</div>
                  <span class="bubble-time">{{ fmtTime(m.createdAt) }}</span>
                </div>
              </div>
            </div>
          </div>
          <footer class="chat-foot">
            <el-input v-model="text" placeholder="输入消息... 按 Enter 发送" size="large"
              @keyup.enter.exact="sendMsg" :disabled="sending" class="foot-input" />
            <el-button type="primary" :icon="Promotion" @click="sendMsg" :loading="sending" round>发送</el-button>
          </footer>
        </template>
        <div v-else class="no-chat">
          <span class="no-chat-icon">💬</span>
          <h3>选择一个会话</h3>
          <p>浏览商品时点击「联系卖家」即可发起对话</p>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted, nextTick, computed } from 'vue'
import { useRoute } from 'vue-router'
import { messageApi } from '@/api'
import { getUserInfo } from '@/utils/auth'
import { Search, Promotion } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const route = useRoute()
const myId = computed(() => getUserInfo()?.userId)
const conversations = ref<any[]>([])
const messages = ref<any[]>([])
const selectedUserId = ref<number | null>(null)
const selectedUser = ref<any>(null)
const text = ref('')
const msgBox = ref<any>(null)
const sending = ref(false)
const loading = ref(true)
const searchText = ref('')
let poller: any = null

const totalUnread = computed(() => conversations.value.reduce((s:number,c:any)=>s+(c.unreadCount||0),0))
const filteredConvs = computed(() => {
  if (!searchText.value) return conversations.value
  const kw = searchText.value.toLowerCase()
  return conversations.value.filter((c:any) => (c.nickname||'').toLowerCase().includes(kw))
})

onMounted(async () => {
  await loadConvs()
  const to = Number(route.query.to)
  if (to) openChat(to)
  poller = setInterval(poll, 5000)
})
onUnmounted(() => { if (poller) clearInterval(poller) })

async function loadConvs() {
  try { const r = await messageApi.getConversations(); conversations.value = r.data || [] } catch(_){} finally { loading.value = false }
}
async function poll() {
  if (!selectedUserId.value) return
  try {
    const r = await messageApi.getConversation(selectedUserId.value, {page:1,size:50})
    if ((r.data||[]).length !== messages.value.length) {
      messages.value = [...(r.data||[])].reverse()
      scrollBottom()
      loadConvs()
    }
  } catch(_){}
}
function openChat(uid: number) {
  selectedUserId.value = uid
  const ex = conversations.value.find(c=>c.userId===uid)
  if (ex) { selectedUser.value = ex; loadMsgs(uid) }
  else { selectedUser.value = {userId:uid, nickname:'用户'+uid}; messages.value = [] }
}
async function selectConversation(c: any) {
  selectedUserId.value = c.userId; selectedUser.value = c
  await loadMsgs(c.userId)
  if (c.unreadCount>0) { await messageApi.markRead(c.userId); c.unreadCount = 0 }
}
async function loadMsgs(uid: number) {
  try { const r = await messageApi.getConversation(uid,{page:1,size:50}); messages.value = (r.data||[]).reverse() } catch(_) { messages.value=[] }
  scrollBottom()
}
async function sendMsg() {
  const t = text.value.trim(); if (!t || !selectedUserId.value) return
  sending.value = true
  try {
    await messageApi.send({toUserId:selectedUserId.value, content:t, type:'text'})
    messages.value.push({id:Date.now(), fromUserId:myId.value, content:t, createdAt:new Date().toISOString()})
    text.value = ''
    loadConvs(); scrollBottom()
  } catch(e:any) { ElMessage.error(e?.message||'发送失败') }
  finally { sending.value = false }
}
function scrollBottom() {
  nextTick(()=>{ if(msgBox.value) msgBox.value.scrollTop = msgBox.value.scrollHeight })
}
function showDateSep(i: number) {
  if (i===0) return true
  const a = new Date(messages[i].createdAt).toDateString()
  const b = new Date(messages[i-1].createdAt).toDateString()
  return a !== b
}
function fmtTime(t: string) {
  if (!t) return ''; const d = new Date(t); const n = Date.now(); const df = n - d.getTime()
  if (df<6e4) return '刚刚'; if (df<36e5) return Math.floor(df/6e4)+'分钟前'
  if (df<864e5) return Math.floor(df/36e5)+'小时前'
  if (df<6048e5) return Math.floor(df/864e5)+'天前'
  return d.toLocaleDateString('zh-CN')
}
function fmtDate(t: string) {
  if (!t) return ''; const d = new Date(t); const n = new Date()
  if (d.toDateString()===n.toDateString()) return '今天'
  const y = new Date(n.getTime()-864e5)
  if (d.toDateString()===y.toDateString()) return '昨天'
  return d.toLocaleDateString('zh-CN',{month:'long',day:'numeric'})
}
</script>

<style scoped>
.msg-page { max-width:1060px; margin:0 auto; }
.msg-container { display:grid; grid-template-columns:320px 1fr; height:calc(100vh - 140px); background:var(--c-surface); border:1px solid var(--c-border); border-radius:16px; overflow:hidden; box-shadow:0 2px 16px rgba(0,0,0,0.04); }

/* Sidebar */
.msg-side { display:flex; flex-direction:column; border-right:1px solid var(--c-border-light); background:#FAFBFC; }
.side-head { display:flex; align-items:center; justify-content:space-between; padding:20px 18px 12px; }
.side-head h2 { font-size:20px; font-weight:800; margin:0; }
.unread-dot { background:var(--c-accent); color:white; font-size:11px; font-weight:700; padding:2px 8px; border-radius:10px; min-width:20px; text-align:center; }
.side-search { padding:0 14px 10px; }
.side-list { flex:1; overflow-y:auto; }
.conv-row { display:flex; align-items:center; gap:12px; padding:12px 16px; cursor:pointer; transition:background .15s; position:relative; }
.conv-row:hover { background:var(--c-primary-bg); }
.conv-row.active { background:var(--c-primary-bg); box-shadow:inset 3px 0 0 var(--c-primary); }
.conv-avatar { position:relative; flex-shrink:0; }
.online-dot { position:absolute; bottom:1px; right:1px; width:10px; height:10px; background:var(--c-accent); border-radius:50%; border:2px solid white; }
.conv-body { flex:1; overflow:hidden; min-width:0; }
.conv-line1 { display:flex; justify-content:space-between; align-items:baseline; margin-bottom:3px; }
.conv-name { font-size:14px; font-weight:600; color:var(--c-text); }
.conv-time { font-size:11px; color:var(--c-muted); flex-shrink:0; }
.conv-line2 { display:flex; justify-content:space-between; align-items:center; }
.conv-preview { font-size:12px; color:var(--c-text-secondary); white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
.conv-badge { background:var(--c-accent); color:white; font-size:10px; font-weight:700; padding:1px 6px; border-radius:8px; flex-shrink:0; }
.side-empty { display:flex; flex-direction:column; align-items:center; padding:40px 20px; color:var(--c-muted); gap:6px; }
.side-empty .empty-icon { font-size:36px; }
.side-empty p { font-size:14px; color:var(--c-text-secondary); margin:0; }
.side-empty span { font-size:12px; }

/* Chat */
.msg-main { display:flex; flex-direction:column; height:100%; overflow:hidden; }
.chat-top { display:flex; align-items:center; gap:12px; padding:16px 20px; border-bottom:1px solid var(--c-border-light); flex-shrink:0; background:white; }
.chat-top-info strong { display:block; font-size:15px; color:var(--c-text); }
.chat-top-info .credit { font-size:11px; color:var(--c-primary); }
.chat-body { flex:1; overflow-y:auto; padding:16px 20px; display:flex; flex-direction:column; gap:4px; background:#FAFBFC; }
.body-empty { display:flex; flex-direction:column; align-items:center; justify-content:center; height:100%; color:var(--c-muted); gap:8px; }
.body-empty .empty-emoji { font-size:48px; }
.body-empty p { font-size:15px; color:var(--c-text-secondary); margin:0; }
.body-empty span { font-size:13px; }
.date-sep { text-align:center; margin:12px 0 8px; }
.date-sep span { font-size:11px; color:var(--c-muted); background:white; padding:2px 12px; border-radius:10px; border:1px solid var(--c-border-light); }

.bubble-row { display:flex; align-items:flex-end; gap:8px; margin-bottom:8px; }
.bubble-row.me { justify-content:flex-end; }
.bubble-avatar { flex-shrink:0; align-self:flex-end; margin-bottom:18px; }
.bubble-wrap { display:flex; flex-direction:column; max-width:65%; }
.bubble { padding:10px 16px; border-radius:18px; font-size:14px; line-height:1.5; word-break:break-word; }
.bubble:not(.mine) { background:white; color:var(--c-text); border-bottom-left-radius:6px; box-shadow:0 1px 2px rgba(0,0,0,0.04); }
.bubble.mine { background:var(--c-primary); color:white; border-bottom-right-radius:6px; }
.bubble-time { font-size:10px; color:var(--c-muted); padding:0 8px; margin-top:2px; }
.bubble-row.me .bubble-time { text-align:right; }
.bubble-row.me .bubble-wrap { align-items:flex-end; }

.no-chat { flex:1; display:flex; flex-direction:column; align-items:center; justify-content:center; gap:12px; color:var(--c-muted); }
.no-chat-icon { font-size:56px; }
.no-chat h3 { font-size:18px; color:var(--c-text-secondary); margin:0; }
.no-chat p { font-size:13px; margin:0; }

/* Footer */
.chat-foot { display:flex; gap:10px; padding:14px 20px; border-top:1px solid var(--c-border-light); background:white; flex-shrink:0; align-items:center; }
.foot-input { flex:1; }

@media(max-width:768px){.msg-container{grid-template-columns:1fr;}.msg-side{display:none;}}
</style>
