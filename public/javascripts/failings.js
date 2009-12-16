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

function add_reply(e) {
  e.style.display = "none";
  var reply_html = "<textarea name='comment' id='comment'></textarea><input type='submit' value='Send Comment' />";
  var pObj = e;
  while (pObj.className != 'feedback')
    pObj = pObj.parentNode;

  var reply_div = document.createElement('div');
  Element.extend(reply_div);
  reply_div.addClassName('reply_wrapper');
  reply_div.innerHTML = reply_html;
  pObj.appendChild(reply_div);
  $('comment').focus();
}