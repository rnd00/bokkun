const autoSubmitPhoto = () => {
  if (document.getElementById('submit_photo')) {
    document.getElementById('submit_photo').addEventListener('change', (event)=>{
      document.querySelector('.form_submit_photo').submit();
    })
  }
}
export { autoSubmitPhoto }
