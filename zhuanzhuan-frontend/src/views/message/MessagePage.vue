<template>
  <div class="message-page">
    <el-row :gutter="20" style="height: calc(100vh - 160px)">
      <el-col :span="8">
        <el-card style="height:100%">
          <template #header>会话列表</template>
          <div v-for="conv in conversations" :key="conv.userId" class="conv-item" :class="{ active: selectedUserId === conv.userId }" @click="selectConversation(conv)">
            <el-avatar :size="40" :src="conv.avatar" />
            <div class="conv-info">
              <p class="conv-name">{{ conv.nickname }}</p>
              <p class="conv-msg">{{ conv.lastMessage }}</p>
            </div>
            <el-badge :value="conv.unreadCount" :hidden="!conv.unreadCount" />
          </div>
          <el-empty v-if="!conversations.length" description="暂无会话" />
        </el-card>
      </el-col>
      <el-col :span="16">
        <el-card style="height:100%;display:flex;flex-direction:column">
          <template #header>{{ selectedUser?.nickname || '选择会话' }}</template>
          <div class="messages" ref="msgContainer">
            <div v-for="msg in messages" :key="msg.id" class="msg" :class="{ mine: msg.fromUserId === userId }">
              <div class="msg-bubble">{{ msg.content }}</div>
            </div>
          </div>
          <div class="msg-input" v-if="selectedUserId">
            <el-input v-model="inputMsg" placeholder="输入消息..." @keyup.enter="send" />
            <el-button type="primary" @click="send">发送</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick, computed } from 'vue'
import { messageApi } from '@/api'
import { getUserInfo } from '@/utils/auth'

const userId = computed(() => getUserInfo()?.userId)
const conversations = ref<any[]>([])
const messages = ref<any[]>([])
const selectedUserId = ref<number | null>(null)
const selectedUser = ref<any>(null)
const inputMsg = ref('')
const msgContainer = ref<any>(null)

onMounted(async () => {
  const res = await messageApi.getConversations()
  conversations.value = res.data || []
})

async function selectConversation(conv: any) {
  selectedUserId.value = conv.userId
  selectedUser.value = conv
  const res = await messageApi.getConversation(conv.userId, { page: 1, size: 50 })
  messages.value = (res.data || []).reverse()
  await messageApi.markRead(conv.userId)
  conv.unreadCount = 0
  nextTick(() => { if (msgContainer.value) msgContainer.value.scrollTop = msgContainer.value.scrollHeight })
}

async function send() {
  if (!inputMsg.value.trim()) return
  await messageApi.send({ toUserId: selectedUserId.value, content: inputMsg.value, type: 'text' })
  messages.value.push({ fromUserId: userId.value, content: inputMsg.value, id: Date.now() })
  inputMsg.value = ''
  nextTick(() => { if (msgContainer.value) msgContainer.value.scrollTop = msgContainer.value.scrollHeight })
}
</script>

<style scoped>
.conv-item { display: flex; align-items: center; gap: 12px; padding: 12px; cursor: pointer; border-bottom: 1px solid #f0f0f0; }
.conv-item.active { background: #ecf5ff; }
.conv-info { flex: 1; overflow: hidden; }
.conv-name { margin: 0; font-weight: bold; }
.conv-msg { margin: 0; font-size: 12px; color: #909399; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.messages { flex: 1; overflow-y: auto; padding: 16px; }
.msg { margin-bottom: 12px; display: flex; }
.msg.mine { justify-content: flex-end; }
.msg-bubble { max-width: 60%; padding: 10px 14px; border-radius: 8px; background: #f0f0f0; }
.msg.mine .msg-bubble { background: #409eff; color: #fff; }
.msg-input { display: flex; gap: 8px; padding: 12px; border-top: 1px solid #e4e7ed; }
</style>
