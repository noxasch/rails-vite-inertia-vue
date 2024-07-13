<script setup lang="ts">
  import { Link } from '@inertiajs/vue3'
  import api from '~/api'
  
  defineProps<{ posts: any[] }>()
</script>

<template>
  <section class="bg-white dark:bg-gray-900">
  <div class="py-8 px-4 mx-auto max-w-screen-xl lg:py-16 lg:px-6">
      <div class="mx-auto max-w-screen-sm text-center lg:mb-16 mb-8">
          <h2 class="mb-4 text-3xl lg:text-4xl tracking-tight font-extrabold text-gray-900 dark:text-white">Blog Post</h2>
      </div> 
      <div class="grid gap-8 lg:grid-cols-2">
          <article v-for="post in posts" class="p-6 bg-white rounded-lg border border-gray-200 shadow-md dark:bg-gray-800 dark:border-gray-700">
              <h2 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white"><Link :href="api.usersPosts.show.path({ id: post.id })">{{ post.title }}</Link></h2>
              <p class="mb-5 font-light text-gray-500 dark:text-gray-400">{{  post.body }}.</p>
              <div class="flex justify-between items-center">
                  <Link :href="api.usersPosts.show.path({ id: post.id })" class="inline-flex items-center font-medium text-primary-600 dark:text-primary-500 hover:underline">
                    Read more
                      <svg class="ml-2 w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                  </Link>
              </div>
          </article>              
      </div>  
  </div>
</section>
</template>
