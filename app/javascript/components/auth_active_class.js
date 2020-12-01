import { preventInsignificantClick } from "@rails/ujs";

const authActive = () => {
  if(window.location.pathname.includes('/sign_up')){
    const signUp = document.getElementById("sign-up")
    signUp.classList.add("active");
  } else if(window.location.pathname.includes('/sign_in')){
    const signIn = document.getElementById("sign-in")
    signIn.classList.add("active");
  }
};

export default authActive;
