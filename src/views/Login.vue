<template>
  <div class="flex min-h-full items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="w-full max-w-md space-y-8">
      <div>
        <img class="mx-auto h-20 w-auto" src="../assets/HSB-Logo.png" alt="Your Company">
        <h2 class="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900">Verbinden Sie Ihre Wallet</h2>
        <p class="mt-2 text-center text-sm text-gray-600">
          Oder
          <a href="#" class="font-medium text-indigo-600 hover:text-indigo-500">schicken Sie eine Bewerbung ab</a>
        </p>
      </div>
        <div>
          <button type="submit"
                  :disabled="walletStore.walletData != null"
                  :class="
                walletStore.walletData == null ? 'hover:bg-indigo-600' : ''
              "
                  @click="getStudentData()"
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

interface Message {
  from: string
  text: string
  datetime: Date
}
export default defineComponent({
  name: 'Login',

  setup() {
    const walletStore = useWalletStore()
    const contractAddress = process.env.VUE_APP_ADDRESS_STUDENT || ''

    const students = ref<string[]>([])
    const allMessages = ref<Message[]>([])




    const getStudentData = async function () {
      await connectWallet()

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
          console.log('allWaves :>> ', data)

          // allMessages.value = data
        } catch (error) {
          console.error(error)
        }
      }
    }

    const connectWallet = async () => {
      try {
        // @ts-expect-error Window.ethereum not typed
        const data = await window.ethereum.request({
          method: 'eth_requestAccounts',
        })
        console.log('data :>> ', data)
        // this.userAddress = data[0]
        walletStore.saveWalletData(data[0])
        console.log('DApp connected to your wallet 💰')
      } catch (error) {
        console.error('Error connecting DApp to your wallet')
      }
    }
    return {
      getStudentData,
      connectWallet,
      walletStore,
      //students,
    }
  },
})
</script>

<style scoped>

</style>