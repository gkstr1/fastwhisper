console.log("Hi Glen!")

let name = "Mehran"
const numberStr = "2"
let color = "red"

if (numberStr !== 2) {
    console.log(color);
    color = "green"
}


// const nameObject = document.getElementById("name")
const nameObject = document.querySelector("#name")
nameObject.innerText= name;
nameObject.style.color = color

const friends = ["Alex", "Joey", "Vinnie", "Tyrone"]

//  const friendObj = document.getElementsByClassName("friend")[0]
const friendObj = document.querySelector(".friends")

// for (let i = 0; i < friends.length; i++) {
//     const currentText = friendObj.innerText
//     friendObj.innerText = `${currentText} ${friends[i]}`
// }

// const setNames = (friend) => {
//     const currentText = friendObj.innerText;
//     friendObj.innerText = `${currentText} ${friend}`
// }

// friends.forEach(setNames)

// function hello() {
//     console.log("Hello!")
// }

// ((username) => {
//     console.log(`Hello ${username}!`)
// })();

const friendsNames = friends.join(" ");
friendObj.innerText = friendsNames;