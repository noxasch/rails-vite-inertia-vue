<script setup lang="ts">
  defineProps<{ user: any, sign_up_path: string }>()
</script>

<template>
  <div>
    Sign Up {{ JSON.stringify(user) }}
  </div>
</template>
