const $ = element => document.querySelector(element)
const getPower = () => {
  console.loog('power')
}

const $list = $('#list')

if ($list instanceof HTMLElement) {
  $list.addEventListener('click', () => {
    console.log('clicked')
  })
}


