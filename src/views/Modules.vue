<template>


  <div class="relative  sm:rounded-lg py-12 px-4 sm:px-6 lg:px-8">
    <h2 class="mb-4 mt-8 text-left text-3xl font-extrabold leading-none tracking-tight text-gray-900 md:text-4xl dark:text-white">Modul hinzufügen</h2>
    <form>
      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Modulinformationen
      </h6>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Modulname
            </label>
            <input v-model="name" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Maximale Teilnehmeranzahl
            </label>
            <input v-model="memberLimit" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Erfordertes Semester
            </label>
            <input v-model="semester" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Erforderter Studiengang
            </label>
            <input v-model="degree" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Lehrender
            </label>
            <input v-model="teacher" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
          </div>
        </div>
      </div>

      <hr class="mt-6 border-b-1 border-blueGray-300">

      <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">
        Erforderte Kurse
      </h6>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-12/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Address
            </label>
            <input type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              City
            </label>
            <input type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Country
            </label>
            <input type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
          </div>
        </div>
        <div class="w-full lg:w-4/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Postal Code
            </label>
            <input type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
          </div>
        </div>
      </div>
      <button @click="addCourse" type="button" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Button
      </button>

      <hr class="mt-6 border-b-1 border-blueGray-300">

    </form>

    <h2 class="mb-4 mt-14 pt-20 text-left text-3xl font-extrabold leading-none tracking-tight text-gray-900 md:text-4xl dark:text-white">Modulliste</h2>
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
      <tr>
        <th scope="col" class="px-6 py-3">
          ID
        </th>
        <th scope="col" class="px-6 py-3">
          Titel
        </th>
        <th scope="col" class="px-6 py-3">
          Lehrender
        </th>
        <th scope="col" class="px-6 py-3">
          Verfügbarkeit
        </th>
        <th scope="col" class="px-6 py-3">
          Aktion
        </th>
      </tr>
      </thead>
      <tbody>
      <tr  class="bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-600"
          v-for="course in allCourses" :key="course"
      >
        <td class="px-6 py-4">
          {{course.id}}
        </td>
        <td class="px-6 py-4">
          {{course.name}}
        </td>
        <td class="px-6 py-4">
          {{course.createdByProf}}
        </td>
        <td class="px-6 py-4">
          {{course.available}}
        </td>

        <td class="px-6 py-4">
          <a href="#" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit user</a>
        </td>
      </tr>
      </tbody>
    </table>

    <h2 class="mb-4 mt-14 pt-20 text-left text-3xl font-extrabold leading-none tracking-tight text-gray-900 md:text-4xl dark:text-white">Meine Module</h2>
    <table class="w-full  text-sm text-left text-gray-500 dark:text-gray-400">
      <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
      <tr>
        <th scope="col" class="px-6 py-3">
          ID
        </th>
        <th scope="col" class="px-6 py-3">
          Titel
        </th>
        <th scope="col" class="px-6 py-3">
          Lehrender
        </th>
        <th scope="col" class="px-6 py-3">
          Verfügbarkeit
        </th>
        <th scope="col" class="px-6 py-3">
          Aktion
        </th>
      </tr>
      </thead>
      <tbody>
      <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
        <td class="w-4 p-4">
          <div class="flex items-center">
            <input id="checkbox-table-search-1" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
            <label for="checkbox-table-search-1" class="sr-only">checkbox</label>
          </div>
        </td>
        <th scope="row" class="flex items-center px-6 py-4 text-gray-900 whitespace-nowrap dark:text-white">
          <img class="w-10 h-10 rounded-full" src="/docs/images/people/profile-picture-1.jpg" alt="Jese image">
          <div class="pl-3">
            <div class="text-base font-semibold">Neil Sims</div>
            <div class="font-normal text-gray-500">neil.sims@flowbite.com</div>
          </div>
        </th>
        <td class="px-6 py-4">
          React Developer
        </td>
        <td class="px-6 py-4">
          <div class="flex items-center">
            <div class="h-2.5 w-2.5 rounded-full bg-green-500 mr-2"></div> Online
          </div>
        </td>
        <td class="px-6 py-4">
          <a href="#" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit user</a>
        </td>
      </tr>
      <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
        <td class="w-4 p-4">
          <div class="flex items-center">
            <input id="checkbox-table-search-2" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
            <label for="checkbox-table-search-2" class="sr-only">checkbox</label>
          </div>
        </td>
        <th scope="row" class="flex items-center px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
          <img class="w-10 h-10 rounded-full" src="/docs/images/people/profile-picture-3.jpg" alt="Jese image">
          <div class="pl-3">
            <div class="text-base font-semibold">Bonnie Green</div>
            <div class="font-normal text-gray-500">bonnie@flowbite.com</div>
          </div>
        </th>
        <td class="px-6 py-4">
          Designer
        </td>
        <td class="px-6 py-4">
          <div class="flex items-center">
            <div class="h-2.5 w-2.5 rounded-full bg-green-500 mr-2"></div> Online
          </div>
        </td>
        <td class="px-6 py-4">
          <a href="#" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit user</a>
        </td>
      </tr>
      <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
        <td class="w-4 p-4">
          <div class="flex items-center">
            <input id="checkbox-table-search-2" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
            <label for="checkbox-table-search-2" class="sr-only">checkbox</label>
          </div>
        </td>
        <th scope="row" class="flex items-center px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
          <img class="w-10 h-10 rounded-full" src="/docs/images/people/profile-picture-2.jpg" alt="Jese image">
          <div class="pl-3">
            <div class="text-base font-semibold">Jese Leos</div>
            <div class="font-normal text-gray-500">jese@flowbite.com</div>
          </div>
        </th>
        <td class="px-6 py-4">
          Vue JS Developer
        </td>
        <td class="px-6 py-4">
          <div class="flex items-center">
            <div class="h-2.5 w-2.5 rounded-full bg-green-500 mr-2"></div> Online
          </div>
        </td>
        <td class="px-6 py-4">
          <a href="#" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit user</a>
        </td>
      </tr>
      <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
        <td class="w-4 p-4">
          <div class="flex items-center">
            <input id="checkbox-table-search-2" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
            <label for="checkbox-table-search-2" class="sr-only">checkbox</label>
          </div>
        </td>
        <th scope="row" class="flex items-center px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
          <img class="w-10 h-10 rounded-full" src="/docs/images/people/profile-picture-5.jpg" alt="Jese image">
          <div class="pl-3">
            <div class="text-base font-semibold">Thomas Lean</div>
            <div class="font-normal text-gray-500">thomes@flowbite.com</div>
          </div>
        </th>
        <td class="px-6 py-4">
          UI/UX Engineer
        </td>
        <td class="px-6 py-4">
          <div class="flex items-center">
            <div class="h-2.5 w-2.5 rounded-full bg-green-500 mr-2"></div> Online
          </div>
        </td>
        <td class="px-6 py-4">
          <a href="#" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit user</a>
        </td>
      </tr>
      <tr class="bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-600">
        <td class="w-4 p-4">
          <div class="flex items-center">
            <input id="checkbox-table-search-3" type="checkbox" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600">
            <label for="checkbox-table-search-3" class="sr-only">checkbox</label>
          </div>
        </td>
        <th scope="row" class="flex items-center px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
          <img class="w-10 h-10 rounded-full" src="/docs/images/people/profile-picture-4.jpg" alt="Jese image">
          <div class="pl-3">
            <div class="text-base font-semibold">Leslie Livingston</div>
            <div class="font-normal text-gray-500">leslie@flowbite.com</div>
          </div>
        </th>
        <td class="px-6 py-4">
          SEO Specialist
        </td>
        <td class="px-6 py-4">
          <div class="flex items-center">
            <div class="h-2.5 w-2.5 rounded-full bg-red-500 mr-2"></div> Offline
          </div>
        </td>
        <td class="px-6 py-4">
          <a href="#" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Edit user</a>
        </td>
      </tr>
      </tbody>
    </table>
  </div>



</template>

<script lang="ts">
import {defineComponent, ref} from "vue";
import {ethers} from "ethers";
import Studentmngmt from "@/artifacts/solidity/contracts/Studentmngmt.sol/Studentmngmt.json";
import {useWalletStore} from "@/stores/wallet";

interface Course {
  id: number
  name: string
  memberLimit: string
  memberCount: string
  degree: string
  semester: string
  isCourseRequired: boolean
  createdByProf: any
  available: boolean
}

export default defineComponent( {
  name: "Modules",

  setup() {
    const trxInProgress = ref<boolean>(false)

    const walletStore = useWalletStore()

    const contractAddress = process.env.VUE_APP_ADDRESS_STUDENT || ''

    const name = ref('')
    const degree = ref('')
    const semester = ref('')
    const memberLimit = ref('')
    const teacher = ref('')
    const isCourseRequired = ref(false)
    const isAvailable = ref(false)
    const requiredCourses = ref<number[]>([])

    const allCourses = ref<Course[]>([])


    const getCourses = async function () {
      allCourses.value = []

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
          data.forEach((course: any) => {
            allCourses.value.push({
              id: course.ID.toString(),
              name: course.name,
              memberLimit: course.memberLimit.toString(),
              memberCount: course.memberCount.toString(),
              degree: course.degree,
              semester: course.semester.toString(),
              isCourseRequired: course.isCourseRequired,
              createdByProf: course.createdByProf,
              available: course.available
            })
          })
          console.log()
          console.log(allCourses.value[5])
        } catch (error) {
          console.error(error)
        }
      }
    }

    const addCourse = async function () {
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
          const transaction = await contract.addNewCourse(
              [], name.value, memberLimit.value, degree.value, semester.value, isCourseRequired.value, teacher.value, isAvailable.value
          )
          // wait for the transaction to actually settle in the blockchain
          await transaction.wait()
          console.log('transaction :>> ', transaction)
          //@ts-expect-error because why not
          this.getCourses();
          console.log('c :>> ', allCourses.value)
          //message.value = ''
          name.value = ''
          degree.value = ''
          semester.value = ''
          memberLimit.value = ''
          teacher.value = ''
          isCourseRequired.value = false
          isAvailable.value = false
          requiredCourses.value = []
          trxInProgress.value = false


        } catch (error) {
          console.error(error)
          trxInProgress.value = false
        }
      }
    }

    return {
      addCourse,
      getCourses,
      allCourses,
      walletStore,
      name,
      degree,
      semester,
      memberLimit,
      teacher,
      isCourseRequired,
      isAvailable,
      requiredCourses,
      trxInProgress,
    }

  },
  mounted() {
    if (this.walletStore.walletData === null) {
      console.log('No connected Wallet!')
      this.$router.push({name:'Home'});
    }
    this.getCourses();
  },
  computed: {
    accAvailable() {
      return useWalletStore().walletData
    },
  },
  watch: {
    accAvailable(newVal, old) {
      console.log(`updating from ${old} to ${newVal}`)
      this.getCourses()
    },
  },

})
</script>

<style scoped>

</style>