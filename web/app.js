 const tg = window.Telegram.WebApp;
 const initData = tg.initData;
 const user = tg.initDataUnsafe.user;

window.state = {
    userData: JSON.stringify(user)
}