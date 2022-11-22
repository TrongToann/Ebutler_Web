function activeProduct() {
  document.getElementById('product').classList.add('active') ;
  document.getElementById('service').classList.remove('active') ;
  document.getElementById('order').classList.remove('active') ;
  document.getElementById('staff').classList.remove('active') ;
}
function activeService() {
  document.getElementById('product').classList.remove('active') ;
  document.getElementById('service').classList.add('active') ;
  document.getElementById('order').classList.remove('active') ;
  document.getElementById('staff').classList.remove('active') ;
}
function activeOrder() {
  document.getElementById('product').classList.remove('active') ;
  document.getElementById('service').classList.remove('active') ;
  document.getElementById('order').classList.add('active') ;
  document.getElementById('staff').classList.remove('active') ;
}
function activeStaff() {
  document.getElementById('product').classList.remove('active') ;
  document.getElementById('service').classList.remove('active') ;
  document.getElementById('order').classList.remove('active') ;
  document.getElementById('staff').classList.add('active') ;
}
function ShowPopusEdit() {
  document.querySelector(".overlay").classList.toggle('show') ; 
}
submitForms = function(){
    document.getElementById("form1").submit();
    document.getElementById("form2").submit();
} ; 
submitForms2 = function(){
    document.getElementById("form3").submit();
    document.getElementById("form4").submit(); 
} ;

