<template>
  <div class="flex min-h-full items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="w-full max-w-md space-y-8">
      <div>
        <img class="mx-auto h-20 w-auto" src="../assets/HSB-Logo.png" alt="Your Company">
        <h2 class="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900">Verbinden Sie Ihre Wallet</h2>
        <p class="mt-2 text-center text-sm text-gray-600">
          Oder
          <router-link class="font-medium text-indigo-600 hover:text-indigo-500" to="/register">schicken Sie eine Bewerbung ab</router-link>

        </p>
      </div>
        <div>
          <button type="submit"
                  :disabled="walletStore.walletData != null"
                  :class="
                walletStore.walletData == null ? 'hover:bg-indigo-600' : ''
              "
                  @click="connectWallet()"
                  class="group relative flex w-full justify-center rounded-md bg-indigo-400 py-2 px-3 text-sm font-semibold text-white hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
            <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5 mr-2"
                viewBox="0 0 20 20"
                fill="currentColor"
            >
              <path
                  fill-rule="evenodd"
                  d="M17.778 8.222c-4.296-4.296-11.26-4.296-15.556 0A1 1 0 01.808 6.808c5.076-5.077 13.308-5.077 18.384 0a1 1 0 01-1.414 1.414zM14.95 11.05a7 7 0 00-9.9 0 1 1 0 01-1.414-1.414 9 9 0 0112.728 0 1 1 0 01-1.414 1.414zM12.12 13.88a3 3 0 00-4.242 0 1 1 0 01-1.415-1.415 5 5 0 017.072 0 1 1 0 01-1.415 1.415zM9 16a1 1 0 011-1h.01a1 1 0 110 2H10a1 1 0 01-1-1z"
                  clip-rule="evenodd"
              />
            </svg>
            <span class="">{{
                walletStore.walletData != null
                    ? `Verbunden ${walletStore.walletData.slice(
                        0,
                        2
                    )}...${walletStore.walletData.slice(-4)}`
                    : `Verbinde`
              }}</span>
          </button>
        </div>
    </div>
  </div>
</template>

<script lang="ts">
import {defineComponent, ref} from 'vue'
import { useWalletStore } from '@/stores/wallet'
import { ethers } from 'ethers'

import StudentData from '@/artifacts/solidity/contracts/Studentmngmt.sol/Studentmngmt.json'
import {address} from "hardhat/internal/core/config/config-validation";
import useEmitter from '@/composables/useEmitter'

export default defineComponent({
  name: 'Login',


  setup() {
    const emitter = useEmitter()

    const walletStore = useWalletStore()
    const contractAddress = process.env.VUE_APP_ADDRESS_STUDENT || ''

    const isStudent = ref(false)
    const isRegistered = ref(false)
    const students = ref<string[]>([])
    const profs = ref<string[]>([])
    const sender = ref('')

    const getProfs = async function () {
      //@ts-expect-error Window.ethers not TS
      if (typeof window.ethereum !== 'undefined') {
        //@ts-expect-error Window.ethers not TS
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const contract = new ethers.Contract(
            contractAddress,
            StudentData.abi,
            provider
        )
        console.log('provider ', provider)
        try {
          const data = await contract.getAllProfessorAddresses({})
          profs.value = data
          console.log('allProfs :>> ', profs.value)
        } catch (error) {
          console.error(error)
        }
      }
    }

    const getStudents = async function () {
      //@ts-expect-error Window.ethers not TS
      if (typeof window.ethereum !== 'undefined') {
        //@ts-expect-error Window.ethers not TS
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const contract = new ethers.Contract(
            contractAddress,
            StudentData.abi,
            provider
        )
        console.log('provider ', provider)
        try {
          const data = await contract.getAllStudentAddresses({})
          students.value = data
          console.log('allStudents :>> ', students.value)
        } catch (error) {
          console.error(error)
        }
      }
    }

    const connectWallet = async () => {

      try {

        // @ts-expect-error Window.ethereum not typed
        const data = await window.ethereum.request({
          method: 'eth_accounts',
        })
        console.log('data :>> ', data)

        for (let i = 0; i < students.value.length; i++) {
          if(students.value[i] === ethers.utils.getAddress(data[0]) ) {
            console.log(students.value[i], ethers.utils.getAddress(data[0]))
            walletStore.saveWalletData(ethers.utils.getAddress(data[0]))
            isStudent.value = true;
            isRegistered.value = true;
            console.log('DApp connected to Students Wallet 💰')
            break;
          } else {
            console.log('No student 💰')
          }
        }
        for (let i = 0; i < profs.value.length; i++) {
          if(profs.value[i] === ethers.utils.getAddress(data[0]) ) {
            walletStore.saveWalletData(ethers.utils.getAddress(data[0]))
            isStudent.value = false;
            isRegistered.value = true;
            console.log('DApp connected to Profs Wallet 💰')
            break;
          } else {
            console.log('no prof 💰')
          }

        }
        emitter.emit("isStudent", isStudent.value);
        if(!isRegistered.value) {
          console.log('You are not registered in the System! Please register')
        }
        emitter.emit("isLogged", isRegistered.value);
      } catch (error) {
        console.error('Error connecting DApp to your wallet')
      }

    }
    return {
      getStudents,
      getProfs,
      connectWallet,
      walletStore,
      students,
      profs,
      isStudent,
      isRegistered
    }
  },

  mounted() {
    this.getStudents();
    this.getProfs();
  },
})
</script>

<style scoped>

</style>