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
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Erforderte Kurse
            </label>
            <input v-model="requiredCourses" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4 mb-[0.125rem] block min-h-[1.5rem] pl-[1.5rem]">
          <input
              class="relative float-left mt-[0.15rem] mr-[6px] -ml-[1.5rem] h-[1.125rem] w-[1.125rem] appearance-none rounded-[0.25rem] border-[0.125rem] border-solid border-neutral-300 dark:border-neutral-600 outline-none before:pointer-events-none before:absolute before:h-[0.875rem] before:w-[0.875rem] before:scale-0 before:rounded-full before:bg-transparent before:opacity-0 before:shadow-[0px_0px_0px_13px_transparent] before:content-[''] checked:border-primary dark:checked:border-primary checked:bg-primary dark:checked:bg-primary checked:before:opacity-[0.16] checked:after:absolute checked:after:ml-[0.25rem] checked:after:-mt-px checked:after:block checked:after:h-[0.8125rem] checked:after:w-[0.375rem] checked:after:rotate-45 checked:after:border-[0.125rem] checked:after:border-t-0 checked:after:border-l-0 checked:after:border-solid checked:after:border-white checked:after:bg-transparent checked:after:content-[''] hover:cursor-pointer hover:before:opacity-[0.04] hover:before:shadow-[0px_0px_0px_13px_rgba(0,0,0,0.6)] focus:shadow-none focus:transition-[border-color_0.2s] focus:before:scale-100 focus:before:opacity-[0.12] focus:before:shadow-[0px_0px_0px_13px_rgba(0,0,0,0.6)] focus:before:transition-[box-shadow_0.2s,transform_0.2s] focus:after:absolute focus:after:z-[1] focus:after:block focus:after:h-[0.875rem] focus:after:w-[0.875rem] focus:after:rounded-[0.125rem] focus:after:content-[''] checked:focus:before:scale-100 checked:focus:before:shadow-[0px_0px_0px_13px_#3b71ca] checked:focus:before:transition-[box-shadow_0.2s,transform_0.2s] checked:focus:after:ml-[0.25rem] checked:focus:after:-mt-px checked:focus:after:h-[0.8125rem] checked:focus:after:w-[0.375rem] checked:focus:after:rotate-45 checked:focus:after:rounded-none checked:focus:after:border-[0.125rem] checked:focus:after:border-t-0 checked:focus:after:border-l-0 checked:focus:after:border-solid checked:focus:after:border-white checked:focus:after:bg-transparent"
              type="checkbox"
              v-model="isAvailable"
              checked />
          <label
              class="inline-block pl-[0.15rem] hover:cursor-pointer"
              for="checkboxChecked">
            Soll der Kurs zur Anmeldung freigegeben werden?
          </label>
        </div>
      </div>

      <button @click="addCourse" type="button" class="bg-indigo-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Kurs hinzufügen
      </button>
    </form>

    <hr class="mt-20 border-b-1 border-blueGray-300">
    <h2 class="mb-4 mt-14 pt-10 text-left text-3xl font-extrabold leading-none tracking-tight text-gray-900 md:text-4xl dark:text-white">Modulliste</h2>
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
      </tr>
      </tbody>
    </table>

    <hr class="mt-20 border-b-1 border-blueGray-300">
    <h2 class="mb-4 mt-14 pt-10 text-left text-3xl font-extrabold leading-none tracking-tight text-gray-900 md:text-4xl dark:text-white">Noteneintrag</h2>
    <form>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Kurs ID
            </label>
            <input v-model="courseId" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Note
            </label>
            <input v-model="mark" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
          </div>
        </div>
        <div class="w-full lg:w-12/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Student
            </label>
            <input v-model="studentForCourse" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
          </div>
        </div>
      </div>
      <button @click="addCourse" type="button" class="bg-indigo-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Note hinzufügen
      </button>
    </form>

    <hr class="mt-20 border-b-1 border-blueGray-300">
    <h2 class="mb-4 mt-14 pt-10 text-left text-3xl font-extrabold leading-none tracking-tight text-gray-900 md:text-4xl dark:text-white">Semesterbeitrag hinzufügen</h2>
    <form>
      <div class="flex flex-wrap">
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Semester
            </label>
            <input v-model="semesterForFee" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150">
          </div>
        </div>
        <div class="w-full lg:w-6/12 px-4">
          <div class="relative w-full mb-3">
            <label class="block text-left uppercase text-blueGray-600 text-xs font-bold mb-2" htmlfor="grid-password">
              Student
            </label>
            <input v-model="student" type="text" class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow focus:outline-none focus:ring w-full ease-linear transition-all duration-150" >
          </div>
        </div>
      </div>
      <button @click="addSemesterFee" type="button" class="bg-indigo-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        Semesterbeitrag hinzufügen
      </button>
    </form>


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

export default defineComponent( {
  name: "ProfsPage",

  setup() {
    const trxInProgress = ref<boolean>(false)

    const walletStore = useWalletStore()
    const emitter = useEmitter()

    const isRegistered = ref(false)
    const isStudent = ref(false)

    const contractAddress = process.env.VUE_APP_ADDRESS_STUDENT || ''

    const courseId = ref(0)
    const mark = ref('')
    const studentForCourse = ref('')

    const name = ref('')
    const degree = ref('')
    const semester = ref('')
    const memberLimit = ref('')
    const teacher = ref('')
    const isCourseRequired = ref(false)
    const isAvailable = ref(false)
    const requiredCourses = ref<number[]>([])

    const semesterForFee = ref('')
    const student = ref('')

    const allCourses = ref<Course[]>([])

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

    const addCourse = async function () {
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
          if(requiredCourses.value == [] || requiredCourses.value.length == 0) {
            isCourseRequired.value = false;
          }  else {
            isCourseRequired.value = true;
          }

          const array:number[] = requiredCourses.value;
          console.log(array, isCourseRequired.value);
          console.log(isAvailable.value);
          const transaction = await contract.addNewCourse(
              [], name.value, memberLimit.value, degree.value, semester.value, isCourseRequired.value, teacher.value, isAvailable.value
          )
          await transaction.wait()
          console.log('transaction :>> ', transaction)
          //@ts-expect-error because why not
          this.getCourses();
          console.log('c :>> ', allCourses.value)
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

    const addSemesterFee = async function () {
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
          const transaction = await contract.addSemesterToPay(
              student.value, semesterForFee.value
          )
          await transaction.wait()
          console.log('transaction :>> ', transaction)
          student.value = ''
          semesterForFee.value = ''
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
      addSemesterFee,
      semesterForFee,
      student,
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
      courseId,
      studentForCourse,
      mark,
      trxInProgress,
      isRegistered,
      isStudent,
    }

  },
  mounted() {
    this.emitter.on("isStudent", (isStudent: boolean) => {
      this.isStudent = isStudent;
    });
    this.emitter.on("isLogged", (isRegistered: boolean) => {
      this.isRegistered = isRegistered;
    });
    if(!this.isRegistered && this.isStudent) {
      this.$router.push({name:'Home'});
    }
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