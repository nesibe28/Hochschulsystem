<template>
  <!-- This example requires Tailwind CSS v2.0+ -->
  <nav class="bg-indigo-900">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between h-16">
        <div class="flex">
          <div class="-ml-2 mr-2 flex items-center md:hidden">
            <!-- Mobile menu button -->
            <button
              type="button"
              class="
                inline-flex
                items-center
                justify-center
                p-2
                rounded-md
                text-gray-400
                hover:text-white hover:bg-gray-700
                focus:outline-none
                focus:ring-2
                focus:ring-inset
                focus:ring-white
              "
              aria-controls="mobile-menu"
              aria-expanded="false"
            >
              <span class="sr-only">Open main menu</span>

              <svg
                class="block h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                aria-hidden="true"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M4 6h16M4 12h16M4 18h16"
                />
              </svg>

              <svg
                class="hidden h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                aria-hidden="true"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
          <div class="flex-shrink-0 flex items-center">
            <img
              class="block lg:hidden h-8 w-auto"
              src="../assets/HSB-Logo.png"
              alt="SolidityTips.com logo"
            />
            <img
              class="hidden lg:block h-8 w-auto"
              src="/src/assets/HSB-Logo.png"
              alt="SolidityTips.com logo"
            />
          </div>
          <div class="hidden md:ml-6 md:flex md:items-center md:space-x-4">
            <router-link
              :to="{ name: 'Home' }"
              class="
                bg-indigo-900
                text-white
                px-3
                py-2
                rounded-md
                text-sm
                font-medium
              "
              aria-current="page"
              >Home</router-link
            >

            <router-link
              :to="{ name: 'SemesterFees' }"
              class="
                text-gray-300
                hover:bg-gray-700 hover:text-white
                px-3
                py-2
                rounded-md
                text-sm
                font-medium
              "
              >Semesterbeiträge</router-link
            >

            <router-link
              :to="{ name: 'Modules' }"
              class="
                text-gray-300
                hover:bg-gray-700 hover:text-white
                px-3
                py-2
                rounded-md
                text-sm
                font-medium
              "
              >Module</router-link
            >
          </div>
        </div>
      </div>
    </div>

    <div class="md:hidden" id="mobile-menu">
      <div class="px-2 pt-2 pb-3 space-y-1 sm:px-3">
        <router-link
          :to="{ name: 'Home' }"
          class="
            bg-gray-900
            text-white
            block
            px-3
            py-2
            rounded-md
            text-base
            font-medium
          "
          aria-current="page"
          >Home</router-link
        >

        <router-link
          :to="{ name: 'SemesterFees' }"
          class="
            text-gray-300
            hover:bg-gray-700 hover:text-white
            block
            px-3
            py-2
            rounded-md
            text-base
            font-medium
          "
          >Semesterbeiträge</router-link
        >

        <router-link
          :to="{ name: 'Modules' }"
          class="
            text-gray-300
            hover:bg-gray-700 hover:text-white
            block
            px-3
            py-2
            rounded-md
            text-base
            font-medium
          "
          >Module</router-link
        >
      </div>
    </div>
  </nav>
</template>

<script lang="ts">

</script>
