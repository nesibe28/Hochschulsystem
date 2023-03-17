<template>
  <div class="p-8 pl-40 pr-40">
    <div class="p-8 bg-purple-100 shadow mt-24">
      <div class="grid grid-cols-1 md:grid-cols-1">

        <h1 class="text-4xl font-medium text-gray-700">{{fname}} {{lname}}</h1>
        <p class="font-light text-gray-600 mt-3">Meldeadresse: {{regAddress}}</p>
        <p class="mt-8 text-gray-500">Studiengang: {{degree}}</p>
        <p class="mt-2 text-gray-500">Fachsemester: {{semester}}</p>
      </div>
      <div class="mt-12 flex flex-col justify-center">
        <p class="text-gray-600 text-center font-light lg:px-16">Möchtest du deine Meldeandresse anpassen?</p>

      </div>
      <div class="flex justify-center">
        <div class="w-full lg:w-6/12 px-4 pt-10">
          <div class=" w-full mb-3">
            <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Neue Meldeadresse:
            </label>
            <input v-model="regAddressNew" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
          </div>
        </div>
      </div>
      <button @click="updateAddress" class="text-indigo-500 py-2 px-4  font-medium mt-4">Adresse ändern</button>
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
import Studentmngmt from "@/artifacts/solidity/contracts/Studentmngmt.sol/Studentmngmt.json";

export default defineComponent({
  name: 'Login',


  setup() {
    const trxInProgress = ref<boolean>(false)

    const emitter = useEmitter()

    const walletStore = useWalletStore()
    const contractAddress = process.env.VUE_APP_ADDRESS_STUDENT || ''

    const fname = ref('')
    const lname = ref('')
    const regAddress = ref('')
    const degree = ref('')
    const semester = ref(0)
    const regAddressNew = ref('')

    const isStudent = ref(false)
    const isRegistered = ref(false)


    const getStudentData = async function () {
      //@ts-expect-error Window.ethers not TS
      if (typeof window.ethereum !== 'undefined') {
        //@ts-expect-error Window.ethers not TS
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const contract = new ethers.Contract(
            contractAddress,
            StudentData.abi,
            provider
        )
        try {
          const data = await contract.getStudentDetails(walletStore.walletData)
          fname.value = data[0]
          lname.value = data[1]
          regAddress.value = data[2]
          degree.value = data[3]
          semester.value = data[4]
        } catch (error) {
          console.error(error)
        }
      }
    }

    const updateAddress = async function () {
      //@ts-expect-error Window.ethers not TS
      if (typeof window.ethereum !== 'undefined') {
        trxInProgress.value = true
        //@ts-expect-error Window.ethers not TS
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const signer = provider.getSigner()
        const contract = new ethers.Contract(
            contractAddress,
            Studentmngmt.abi,
            signer
        )
        try {
          const transaction = await contract.updateRegAddressStudent(
              regAddressNew.value
          )
          await transaction.wait()
          await getStudentData();
          console.log('transaction :>> ', transaction)
          regAddressNew.value = ''
          trxInProgress.value = false
        } catch (error) {
          console.error(error)
          trxInProgress.value = false
        }
      }
    }

    return {
      getStudentData,
      updateAddress,
      walletStore,
      fname,
      lname,
      regAddress,
      degree,
      semester,
      regAddressNew,
      isStudent,
      isRegistered
    }
  },

  mounted() {
    this.getStudentData();
  },
})
</script>

<style scoped>

</style>