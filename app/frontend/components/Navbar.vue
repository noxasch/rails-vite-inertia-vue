<script setup lang="ts">
import { onMounted, computed, watch, nextTick } from 'vue'
import { usePage, Link } from '@inertiajs/vue3'
import { initDropdowns } from 'flowbite'
import { usersSessions, usersPosts } from '~/api'

const page = usePage()
const user = computed(() => page.props.auth)

onMounted(() => {
    if(user) {
    initDropdowns()
  }
})

watch(user, async (newUser, _) => {
  await nextTick()
  if (newUser) {
    initDropdowns()
  }
})
</script>

<template>
  <header class="antialiased">
    <nav class="bg-white border-gray-200 px-4 lg:px-6 py-2.5 dark:bg-gray-800">
      <div class="flex flex-wrap justify-between items-center">
        <div class="flex justify-start items-center">
          <a href="javascript:void(0)" class="flex mr-4">
            <span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">Rails + Inertia +
              Vue</span>
          </a>
        </div>

        <div>
          <Link v-if="!user" class="block py-2 px-4 text-sm dark:hover:text-white font-bold hover:cursor-pointer"
            :href="usersSessions.new.path()" as="a">Sign In</Link>
        </div>

        <button v-if="user" type="button"
          class="flex mx-3 text-sm bg-gray-800 rounded-full md:mr-0 focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600"
          id="user-menu-button" aria-expanded="false" data-dropdown-toggle="dropdown">
          <span class="sr-only">Open user menu</span>
          <img class="w-8 h-8 rounded-full" src="https://flowbite.com/docs/images/people/profile-picture-5.jpg"
            alt="user photo">
        </button>
        <!-- Dropdown menu -->
        <div v-if="user"
          class="hidden z-50 my-4 w-56 text-base list-none bg-white rounded divide-y divide-gray-100 shadow dark:bg-gray-700 dark:divide-gray-600"
          id="dropdown">
          <div class="py-3 px-4">
            <span class="block text-sm font-semibold text-gray-900 dark:text-white">User</span>
            <span class="block text-sm text-gray-500 truncate dark:text-gray-400">{{ (user as any).email }}</span>
          </div>
          <ul class="py-1 text-gray-500 dark:text-gray-400" aria-labelledby="dropdown">
            <li>
              <a
                class="block py-2 px-4 text-sm hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:cursor-pointer"
                :href="usersPosts.new.path()" as="span">New Posts</a>
            </li>
            <li>
              <a
                class="block py-2 px-4 text-sm hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:cursor-pointer"
                :href="usersPosts.index.path()" as="span">Posts</a>
            </li>
            <li>
              <Link
                class="block py-2 px-4 text-sm hover:bg-gray-100 dark:hover:bg-gray-600 dark:hover:text-white hover:cursor-pointer"
                :href="usersSessions.destroy.path()" method="delete" as="span">Logout</Link>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </header>
</template>
