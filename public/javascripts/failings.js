function show_login() {
  $('login_form').show();
  $('signup_form').hide();
  $('login_username').focus();
}
function show_signup() {
  $('login_form').hide();
  $('signup_form').show();
  $('username').focus();
}