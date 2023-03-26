// eslint-disable-next-line @typescript-eslint/no-var-requires
const hre = require('hardhat')

const main = async () => {
  const studentContractFactory = await hre.ethers.getContractFactory('Studentmngmt')
  const studentContract = await studentContractFactory.deploy({})

  await studentContract.deployed()

  console.log('StudentData address: ', studentContract.address)

}

const runMain = async () => {
  try {
    await main()
    process.exit(0)
  } catch (error) {
    console.error(error)
    process.exit(1)
  }
}

runMain()
