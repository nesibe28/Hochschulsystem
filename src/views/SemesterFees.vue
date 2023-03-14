<template>
  <div class="relative overflow-x-auto py-12 px-4 sm:px-6 lg:px-8">
    <h2 class="mb-4 text-left text-3xl font-extrabold leading-none tracking-tight text-gray-900 md:text-4xl dark:text-white">Semesterbeiträge</h2>
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
      <tr>
        <th scope="col" class="px-6 py-3">
          Semester
        </th>
        <th scope="col" class="px-6 py-3">
          Betrag
        </th>
        <th scope="col" class="px-6 py-3">
          Status
        </th>
        <th scope="col" class="px-6 py-3">
          Aktion
        </th>
      </tr>
      </thead>
      <tbody>
      <tr  class="bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-600"
           v-for="fee in allFees" :key="fee.tokenID"
      >
        <td class="px-6 py-4">
          {{fee.tokenID}}
        </td>
        <td class="px-6 py-4">
          {{fee.student}}
        </td>
        <td class="px-6 py-4">
          {{fee.semester}}
        </td>
        <td class="px-6 py-4">
          {{fee.isPayed}}
        </td>

        <td class="px-6 py-4">
          <button @click="payFee" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Bezahlen</button>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script lang="ts">
import {ethers} from "ethers";
import Studentmngmt from "@/artifacts/solidity/contracts/Studentmngmt.sol/Studentmngmt.json";
import {defineComponent, ref} from "vue";
import {useWalletStore} from "@/stores/wallet";

interface Fee {
  tokenID: number
  semester: string
  student: string
  isPayed: boolean
}

export default defineComponent(  {
  name: "Registration",

  setup() {
    const trxInProgress = ref<boolean>(false)

    const walletStore = useWalletStore()

    const contractAddress = process.env.VUE_APP_ADDRESS_STUDENT || ''

    const tokenID = ref('')
    const semester = ref('')
    const student = ref('')
    const isPayed = ref(false)

    const allFees = ref<Fee[]>([])

    const getFees = async function () {
      allFees.value = []

      //@ts-expect-error Window.ethers not TS
      if (typeof window.ethereum !== 'undefined') {
        //@ts-expect-error Window.ethers not TS
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        const contract = new ethers.Contract(
            contractAddress,
            Studentmngmt.abi,
            provider
        )
        try {
          const data = await contract.getAllCourses({})
          console.log('allCourses :>> ', data)
          data.forEach((fee: any) => {
            allFees.value.push({
              tokenID: fee.tokenID.toString(),
              semester: fee.semester,
              student: fee.student,
              isPayed: fee.isPayed
            })
          })
        } catch (error) {
          console.error(error)
        }
      }
    }

    const payFee = async function () {
      //@ts-expect-error Window.ethers not TS
      if (typeof window.ethereum !== 'undefined') {
        trxInProgress.value = true
        //@ts-expect-error Window.ethers not TS
        const provider = new ethers.providers.Web3Provider(window.ethereum)
        // get the account that will pay for the trasaction
        const signer = provider.getSigner()
        // as the operation we're going to do is a transaction,
        // we pass the signer instead of the provider
        const contract = new ethers.Contract(
            contractAddress,
            Studentmngmt.abi,
            signer
        )
        try {
          const transaction = await contract.paySemester(
              semester.value
          )
          // wait for the transaction to actually settle in the blockchain
          await transaction.wait()
          console.log('transaction :>> ', transaction)
          //message.value = ''
          semester.value = ''
          trxInProgress.value = false
        } catch (error) {
          console.error(error)
          trxInProgress.value = false
        }
      }
    }

    return {
      getFees,
      payFee,
      allFees,
      walletStore,
      tokenID,
      student,
      isPayed,
      semester,
      trxInProgress,
    }

  },
  mounted() {
    if (this.walletStore.walletData !== null) {
      console.log('There is a wallet connected!')
    }
  },
  computed: {
    accAvailable() {
      return useWalletStore().walletData
    },
  },
  watch: {
    accAvailable(newVal, old) {
      console.log(`updating from ${old} to ${newVal}`)
    },
  },

})



</script>

<style scoped>

</style>