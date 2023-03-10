<template>
  <div class="p-40 pl-40 pr-40 grid grid-cols-1 sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-2 xl:grid-cols-2 gap-20">
    <!--Card 1-->
    <div class="rounded overflow-hidden shadow-lg">
      <div class="px-6 py-4">
        <div class="font-bold text-xl mb-2">Professor Registrierung</div>
        <form>
          <div class="flex flex-wrap pt-10">
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Vorame
                </label>
                <input v-model="fName" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Nachname
                </label>
                <input v-model="lName" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Ethereum-Adresse
                </label>
                <input v-model="ethAddress" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
              </div>
            </div>

          </div>
          <button @click="addProfessor" type="button" class="bg-indigo-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
            Professor hinzufügen
          </button>
        </form>
      </div>
    </div>
    <!--Card 2-->
    <div class="rounded overflow-hidden shadow-lg">
      <div class="px-6 py-4">
        <div class="font-bold text-xl mb-2">Studenten Registrierung</div>
        <form>
          <div class="flex flex-wrap pt-10">
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Vorname
                </label>
                <input v-model="fName" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Nachname
                </label>
                <input v-model="lName" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Ethereum-Adresse
                </label>
                <input v-model="ethAddress" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Meldeadresse
                </label>
                <input v-model="regAddress" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Studiengang
                </label>
                <input v-model="degree" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
              </div>
            </div>
            <div class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
                  Fachsemester
                </label>
                <input v-model="semester" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
              </div>
            </div>

          </div>
          <button @click="addStudent" type="button" class="bg-indigo-500  hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
            Student hinzufügen
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import {ethers} from "ethers";
import Studentmngmt from "@/artifacts/solidity/contracts/Studentmngmt.sol/Studentmngmt.json";
import {defineComponent, ref} from "vue";
import {useWalletStore} from "@/stores/wallet";

export default defineComponent(  {
  name: "Registration",

  setup() {
    const trxInProgress = ref<boolean>(false)

    const walletStore = useWalletStore()

    const contractAddress = process.env.VUE_APP_ADDRESS_STUDENT || ''

    const fName = ref('')
    const lName = ref('')
    const ethAddress = ref('')
    const regAddress = ref('')
    const degree = ref('')
    const semester = ref('')

    const addStudent = async function () {
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
          const transaction = await contract.addNewStudent(
              ethAddress.value, fName.value, lName.value, regAddress.value, degree.value, semester.value
          )
          // wait for the transaction to actually settle in the blockchain
          await transaction.wait()
          console.log('transaction :>> ', transaction)
          //message.value = ''
          ethAddress.value = ''
          fName.value = ''
          lName.value = ''
          regAddress.value = ''
          degree.value = ''
          semester.value = ''
          trxInProgress.value = false
        } catch (error) {
          console.error(error)
          trxInProgress.value = false
        }
      }
    }

    const addProfessor = async function () {
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
          const transaction = await contract.addNewProfessor(
              ethAddress.value, fName.value, lName.value
          )
          // wait for the transaction to actually settle in the blockchain
          await transaction.wait()
          console.log('transaction :>> ', transaction)
          //message.value = ''
          ethAddress.value = ''
          fName.value = ''
          lName.value = ''
          trxInProgress.value = false
        } catch (error) {
          console.error(error)
          trxInProgress.value = false
        }
      }
    }

    return {
      addStudent,
      addProfessor,
      walletStore,
      fName,
      lName,
      ethAddress,
      regAddress,
      degree,
      semester,
      trxInProgress,
    }

  },
  mounted() {
    if (this.walletStore.walletData !== null) {
      console.log('There is a wallet connected!')
      this.$router.push({name:'Modules'});
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