<script setup lang="ts">
  import { computed, reactive } from 'vue'
  import { router, usePage } from '@inertiajs/vue3'


  const page = usePage()
  const usersUrl = computed(() => page.props.users_url)

  const props = defineProps({ post: Object, errors: Object })

  const postForm = reactive({
    post: {
      title: props.post!.title,
      body: props.post!.body,
      public: props.post!.public
    }
  })

  function submit(url: string) {
    router.post(url, postForm)
  }
</script>

<template>
  <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto lg:py-0">
    <div
      class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
      <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
        <h1 class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
          Create Post
        </h1>
        <form class="space-y-4 md:space-y-6" @submit.prevent="submit((usersUrl as any).users_posts_path)">
          <div>
            <label for="title" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Post Title</label>
            <input v-model="postForm.post.title" type="text" name="title" id="title"
              class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
              placeholder="title" required="true">
          </div>
          <div class="sm:col-span-2">
            <label for="body" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Post Content</label>
            <textarea v-model="postForm.post.body" id="body" rows="5"
              class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-primary-500 focus:border-primary-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-primary-500 dark:focus:border-primary-500"
              placeholder="Write a post..." required="true"></textarea>
          </div>
          <div class="flex items-center justify-between">
            <div class="flex items-start">
              <div class="flex items-center h-5">
                <input v-model="postForm.post.public" id="public" aria-describedby="public" type="checkbox"
                  class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800">
              </div>
              <div class="ml-3 text-sm">
                <label for="public" class="text-gray-500 dark:text-gray-300">Public</label>
              </div>
            </div>
          </div>
          <button type="submit"
            class="w-full text-white bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">Create
            Post</button>
        </form>
      </div>
    </div>
    <!-- <FlashAlert v-if="($attrs as Record<string, any>).flash.type === 'error'"
      :message="($attrs as Record<string, any>).flash.message" class="mt-5 sm:max-w-md" /> -->
  </div>
</template>
