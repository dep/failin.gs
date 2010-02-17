// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function show_login() {
  $('login_form').show();
  $('signup_form').hide();
  $('request_form').hide();
  $('login_username').focus();
}
function show_signup() {
  $('login_form').hide();
  $('request_form').hide();
  $('signup_form').show();
  $('username').focus();
}
function show_request() {
  $('login_form').hide();
  $('signup_form').hide();
  $('request_form').show();
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

function ismaxlength(obj){
  var mlength=obj.getAttribute? parseInt(obj.getAttribute("maxlength")) : ""
  if (obj.getAttribute && obj.value.length>mlength)
  obj.value=obj.value.substring(0,mlength)
  if (obj.id == "failing_about") {
    $('char_limit').innerHTML = mlength - obj.value.length;
    if (obj.value.length > 3)
      $('nice_01').show();
    if (obj.value.length > 20)
      $('nice_02').show();
    if (obj.value.length > 40)
      $('nice_03').show();
  }
}
function nice_clear() {
  $('nice_01').fade();
  $('nice_02').fade();
  $('nice_03').fade();
}

function categorize(category, id) {
  alert(category +":"+ id);
}

function getVal(name) {
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec(window.location.href);
  if(results == null)
    return "";
  else
    return results[1];
}
