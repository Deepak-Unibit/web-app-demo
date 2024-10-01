 const tg = window.Telegram.WebApp;
 const initData = tg.initData;
 const user = tg.initDataUnsafe.user;

 console.log(user);

window.state = {
//    hello: 'world'
    userData: user
}