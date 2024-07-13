<script setup lang="ts">
import type { Post } from '~/types'

defineProps<{ post: Post }>()
</script>

<template>
  <section class="relative py-10 lg:py-16 ">
    <div class="w-full max-w-lg md:max-w-2xl lg:max-w-4xl px-5 lg:px-11 mx-auto max-md:px-3">
      <h4 class="font-manrope font-semibold text-2xl leading-9 text-black dark:text-white mb-12">
        {{  post.title }}
      </h4>

      <p class="font-normal text-lg leading-8 text-gray-600 dark:text-gray-400 mb-8">
        {{ post.body }}
      </p>
    </div>
  </section>
</template>
