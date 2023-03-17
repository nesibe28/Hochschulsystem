<template>


  <div class="relative  sm:rounded-lg py-12 px-4 sm:px-6 lg:px-8">
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
          Semester
        </th>
        <th scope="col" class="px-6 py-3">
          Studiengang
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
           v-for="course in allCourses" :key="course.id"
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
          {{course.semester}}
        </td>
        <td class="px-6 py-4">
          {{course.degree}}
        </td>
        <td class="px-6 py-4">
          {{course.available}}
        </td>

        <td class="px-6 py-4">
          <button @click="enrollInCourse(course.id)" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Anmelden</button>
        </td>
      </tr>
      </tbody>
    </table>

    <h2 class="mb-4 mt-14 pt-20 text-left text-3xl font-extrabold leading-none tracking-tight text-gray-900 md:text-4xl dark:text-white">Meine Module</h2>

    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
      <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
      <tr>
        <th scope="col" class="px-6 py-3">
          ID
        </th>
        <th scope="col" class="px-6 py-3">
          Note
        </th>
        <th scope="col" class="px-6 py-3">
          Nimmt teil
        </th>
        <th scope="col" class="px-6 py-3">
          Bestanden
        </th>
        <th scope="col" class="px-6 py-3">
          Aktion
        </th>
      </tr>
      </thead>
      <tbody>
      <tr  class="bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-600"
           v-for="course in studentsCourses" :key="course.id"
      >
        <td class="px-6 py-4">
          {{course.id}}
        </td>
        <td class="px-6 py-4">
          {{course.mark}}
        </td>
        <td class="px-6 py-4">
          {{course.takesPart}}
        </td>
        <td class="px-6 py-4">
          {{course.passed}}
        </td>

        <td class="px-6 py-4">
          <button @click="unsubscribeFromCourse(course.id)" class="font-medium text-blue-600 dark:text-blue-500 hover:underline">Abmelden</button>
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
import useEmitter from "@/composables/useEmitter";

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

interface EnrolledCourse {
  id: number
  student: string
  mark: string
  takesPart: boolean
  passed: boolean
}

export default defineComponent( {
  name: "Modules",

  setup() {
    const trxInProgress = ref<boolean>(false)

    const walletStore = useWalletStore()
    const emitter = useEmitter()

    const contractAddress = process.env.VUE_APP_ADDRESS_STUDENT || ''

    const courseId = ref(0)
    const name = ref('')
    const degree = ref('')
    const semester = ref('')
    const memberLimit = ref('')
    const teacher = ref('')
    const isCourseRequired = ref(false)
    const isAvailable = ref(false)
    const requiredCourses = ref<number[]>([])

    const allCourses = ref<Course[]>([])
    const studentsCourses = ref<EnrolledCourse[]>([])

    const isRegistered = ref(false)

    const getStudentsCourses = async function () {
      studentsCourses.value = []

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
          const data = await contract.getEnrolledCourses(walletStore.walletData)
          console.log('enrolledCourses :>> ', data)
          data.forEach((course: any) => {
            studentsCourses.value.push({
              id: course.ID.toString(),
              student: course.student,
              mark: course.mark.toString(),
              takesPart: course.takesPart,
              passed: course.passed,
            })
          })
        } catch (error) {
          console.error(error)
        }
      }
    }

    const enrollInCourse = async function (courseId: any) {
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
          console.log(courseId);
          const transaction = await contract.enrollInCourse(
              courseId
          )
          // wait for the transaction to actually settle in the blockchain
          await transaction.wait()
          console.log('transaction :>> ', transaction)
          //@ts-expect-error because why not
          await this.getStudentsCourses();
          console.log('c :>> ', studentsCourses.value)
          //courseId.value = 0
          trxInProgress.value = false
        } catch (error) {
          console.error(error)
          trxInProgress.value = false
        }
      }
    }

    const unsubscribeFromCourse = async function (courseId: any) {
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
          console.log(courseId);
          const transaction = await contract.unsubscribeFromCourse(
              courseId,
          {gasLimit: 300000}
          )
          // wait for the transaction to actually settle in the blockchain
          await transaction.wait()
          console.log('transaction :>> ', transaction)
          //@ts-expect-error because why not
          await this.getStudentsCourses();
          console.log('c :>> ', studentsCourses.value)
          //courseId.value = 0
          trxInProgress.value = false
        } catch (error) {
          console.error(error)
          trxInProgress.value = false
        }
      }
    }

    const getCourses = async function () {
      console.log(walletStore.walletData);
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
        } catch (error) {
          console.error(error)
        }
      }
    }

    return {
      getCourses,
      getStudentsCourses,
      enrollInCourse,
      unsubscribeFromCourse,
      studentsCourses,
      emitter,
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
      isRegistered,
    }

  },
  mounted() {
    /*this.emitter.on("isStudent", (isStudent: boolean) => {
      this.isRegistered = isStudent;
    });
    this.emitter.on("isLogged", (isRegistered: boolean) => {
      this.isRegistered = isRegistered;
    });
    if(!this.isRegistered) {
      this.$router.push({name:'Home'});
    }
    console.log(this.isRegistered)*/
    if (this.walletStore.walletData === null) {
      console.log('No connected Wallet!')
      this.$router.push({name:'Home'});
    }
    this.getCourses();
    this.getStudentsCourses();
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