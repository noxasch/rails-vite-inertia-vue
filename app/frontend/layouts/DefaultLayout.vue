<script setup lang="ts">
  import Navbar from '~/components/Navbar.vue'
</script>

<template>
  <Navbar />
  <div class="py-8 px-4 mx-auto max-w-2xl lg:py-16">
    <slot></slot>
  </div>
</template>
