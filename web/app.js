 const tg = window.Telegram.WebApp;
 const initData = tg.initData;
 const user = tg.initDataUnsafe.user;

 console.log(urlParams);
 console.log(startParam);

window.state = {
    userData: JSON.stringify(user)
}