 const tg = window.Telegram.WebApp;
 const initData = tg.initData;
 const user = tg.initDataUnsafe.user;
 console.log(tg);
 console.log(tg.initData);
 console.log(tg.initDataUnsafe.user);
 console.log();

window.state = {
    userData: JSON.stringify(user)
}