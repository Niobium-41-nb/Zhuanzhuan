<template>
  <div class="message-page">
    <div class="msg-layout">
      <!-- Conversation List -->
      <div class="msg-sidebar">
        <div class="msg-sidebar-header">
          <h3>消息</h3>
          <el-badge :value="totalUnread" :hidden="!totalUnread" />
        </div>
        <div class="conv-list">
          <div v-for="conv in conversations" :key="conv.userId"
            class="conv-item" :class="{ active: selectedUserId === conv.userId }"
            @click="selectConversation(conv)">
            <el-avatar :size="44" :src="conv.avatar">
              {{ conv.nickname?.[0] }}
            </el-avatar>
            <div class="conv-info">
              <div class="conv-top">
                <span class="conv-name">{{ conv.nickname }}</span>
                <span class="conv-time" v-if="conv.lastTime">{{ formatTime(conv.lastTime) }}</span>
              </div>
              <p class="conv-msg">{{ conv.lastMessage || '点击开始聊天' }}</p>
            </div>
            <el-badge :value="conv.unreadCount" :hidden="!conv.unreadCount" />
          </div>
          <el-empty v-if="!conversations.length && !loadingConvs" description="暂无消息，去商品页联系卖家吧" />
        </div>
      </div>

      <!-- Chat Area -->
      <div class="msg-chat">
        <template v-if="selectedUserId">
          <div class="chat-header">
            <el-avatar :size="36" :src="selectedUser?.avatar">
              {{ selectedUser?.nickname?.[0] }}
            </el-avatar>
            <span class="chat-name">{{ selectedUser?.nickname || '用户' + selectedUserId }}</span>
          </div>
          <div class="chat-messages" ref="msgContainer">
            <div v-if="messages.length === 0" class="chat-empty">
              <p>这是你们第一次聊天</p>
              <p class="chat-empty-sub">发送一条消息开始交流吧</p>
            </div>
            <div v-for="msg in messages" :key="msg.id"
              class="msg" :class="{ mine: msg.fromUserId === userId }">
              <div class="msg-bubble">{{ msg.content }}</div>
              <div class="msg-time">{{ formatTime(msg.createdAt) }}</div>
            </div>
          </div>
          <div class="chat-input">
            <el-input v-model="inputMsg" placeholder="输入消息..." size="large"
              @keyup.enter="send" :disabled="sending" />
            <el-button type="primary" @click="send" :loading="sending">
              <el-icon style="margin-right:4px"><Promotion /></el-icon>发送
            </el-button>
          </div>
        </template>
        <div v-else class="chat-placeholder">
          <el-icon size="64" color="#ddd"><ChatDotRound /></el-icon>
          <p>选择一个会话开始聊天</p>
          <p class="chat-placeholder-sub">浏览商品时点击「联系卖家」即可发起对话</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick, computed, watch } from 'vue'
import { useRoute } from 'vue-router'
import { messageApi } from '@/api'
import { getUserInfo } from '@/utils/auth'
import { ChatDotRound, Promotion } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const route = useRoute()
const userId = computed(() => getUserInfo()?.userId)
const conversations = ref<any[]>([])
const messages = ref<any[]>([])
const selectedUserId = ref<number | null>(null)
const selectedUser = ref<any>(null)
const inputMsg = ref('')
const msgContainer = ref<any>(null)
const sending = ref(false)
const loadingConvs = ref(true)

const totalUnread = computed(() =>
  conversations.value.reduce((sum: number, c: any) => sum + (c.unreadCount || 0), 0)
)

onMounted(async () => {
  await loadConversations()
  // 如果 URL 带有 ?to=xxx，自动打开该会话
  const toUserId = Number(route.query.to)
  if (toUserId) {
    openConversation(toUserId)
  }
})

async function loadConversations() {
  try {
    const res = await messageApi.getConversations()
    conversations.value = res.data || []
  } catch (_) {} finally { loadingConvs.value = false }
}

function openConversation(toUserId: number) {
  selectedUserId.value = toUserId
  // 尝试从已有会话中找
  const existing = conversations.value.find(c => c.userId === toUserId)
  if (existing) {
    selectedUser.value = existing
    loadMessages(toUserId)
  } else {
    // 新会话：创建一个临时用户对象
    selectedUser.value = { userId: toUserId, nickname: '用户' + toUserId }
    messages.value = []
  }
}

async function selectConversation(conv: any) {
  selectedUserId.value = conv.userId
  selectedUser.value = conv
  await loadMessages(conv.userId)
  if (conv.unreadCount > 0) {
    await messageApi.markRead(conv.userId)
    conv.unreadCount = 0
  }
}

async function loadMessages(toUserId: number) {
  try {
    const res = await messageApi.getConversation(toUserId, { page: 1, size: 50 })
    messages.value = (res.data || []).reverse()
  } catch (_) { messages.value = [] }
  nextTick(() => {
    if (msgContainer.value) msgContainer.value.scrollTop = msgContainer.value.scrollHeight
  })
}

async function send() {
  const text = inputMsg.value.trim()
  if (!text || !selectedUserId.value) return
  sending.value = true
  try {
    await messageApi.send({ toUserId: selectedUserId.value, content: text, type: 'text' })
    messages.value.push({
      id: Date.now(),
      fromUserId: userId.value,
      content: text,
      createdAt: new Date().toISOString()
    })
    inputMsg.value = ''
    // 刷新会话列表以更新最后一条消息
    await loadConversations()
    nextTick(() => {
      if (msgContainer.value) msgContainer.value.scrollTop = msgContainer.value.scrollHeight
    })
  } catch (e: any) {
    ElMessage.error(e?.message || '发送失败')
  } finally { sending.value = false }
}

function formatTime(t: string) {
  if (!t) return ''
  const d = new Date(t)
  const now = new Date()
  const diff = now.getTime() - d.getTime()
  if (diff < 60000) return '刚刚'
  if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前'
  if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前'
  if (diff < 604800000) return Math.floor(diff / 86400000) + '天前'
  return d.toLocaleDateString('zh-CN')
}
</script>

<style scoped>
.message-page {
  max-width: 1100px;
  margin: 0 auto;
}

.msg-layout {
  display: grid;
  grid-template-columns: 340px 1fr;
  height: calc(100vh - 140px);
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-lg);
  overflow: hidden;
}

/* Sidebar */
.msg-sidebar {
  border-right: 1px solid var(--c-border);
  display: flex;
  flex-direction: column;
}

.msg-sidebar-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 18px 20px;
  border-bottom: 1px solid var(--c-border-light);
}

.msg-sidebar-header h3 {
  font-size: 18px;
  font-weight: 700;
}

.conv-list {
  flex: 1;
  overflow-y: auto;
}

.conv-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 20px;
  cursor: pointer;
  transition: background 0.15s;
  border-bottom: 1px solid var(--c-border-light);
}

.conv-item:hover {
  background: var(--c-primary-bg);
}

.conv-item.active {
  background: var(--c-primary-bg);
  border-left: 3px solid var(--c-primary);
  padding-left: 17px;
}

.conv-info {
  flex: 1;
  overflow: hidden;
  min-width: 0;
}

.conv-top {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
}

.conv-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--c-text);
}

.conv-time {
  font-size: 11px;
  color: var(--c-muted);
  flex-shrink: 0;
  margin-left: 8px;
}

.conv-msg {
  margin: 0;
  font-size: 13px;
  color: var(--c-text-secondary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-top: 2px;
}

/* Chat Area */
.msg-chat {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.chat-header {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 14px 20px;
  border-bottom: 1px solid var(--c-border-light);
  flex-shrink: 0;
}

.chat-name {
  font-size: 16px;
  font-weight: 600;
  color: var(--c-text);
}

.chat-placeholder, .chat-empty {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--c-muted);
  gap: 8px;
}

.chat-placeholder p:first-child, .chat-empty p:first-child {
  font-size: 16px;
  color: var(--c-text-secondary);
}

.chat-placeholder-sub, .chat-empty-sub {
  font-size: 13px;
  color: var(--c-muted);
}

.chat-messages {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.msg {
  display: flex;
  flex-direction: column;
  max-width: 70%;
}

.msg.mine {
  align-self: flex-end;
  align-items: flex-end;
}

.msg:not(.mine) {
  align-self: flex-start;
  align-items: flex-start;
}

.msg-bubble {
  padding: 10px 16px;
  border-radius: 16px;
  font-size: 14px;
  line-height: 1.5;
  word-break: break-word;
}

.msg:not(.mine) .msg-bubble {
  background: var(--c-border-light);
  color: var(--c-text);
  border-bottom-left-radius: 4px;
}

.msg.mine .msg-bubble {
  background: var(--c-primary);
  color: white;
  border-bottom-right-radius: 4px;
}

.msg-time {
  font-size: 11px;
  color: var(--c-muted);
  margin-top: 4px;
  padding: 0 4px;
}

/* Input */
.chat-input {
  display: flex;
  gap: 10px;
  padding: 14px 20px;
  border-top: 1px solid var(--c-border-light);
  background: var(--c-bg);
  flex-shrink: 0;
}

.chat-input .el-button {
  flex-shrink: 0;
}

@media (max-width: 768px) {
  .msg-layout {
    grid-template-columns: 1fr;
    height: calc(100vh - 120px);
  }
  .msg-sidebar {
    display: none;
  }
  .msg-sidebar.show {
    display: flex;
  }
}
</style>
