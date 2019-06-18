$('.btn-danger').click(function(){
  result = confirm(I18n.t('alert_message.delete.should_save'))
  if (!result) {
    return false;
  }
})
