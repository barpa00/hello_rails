## 開發環境
* Ruby 版本 3.0.3
* Rails 版本 7.0.1
* 資料庫: PostgreSQL
* 網站部署: Heroku
* 自動化測試: GitHub Action CI


## Heroku 部署
*  申請 Heroku 帳號
*  安裝 Heroku Cli
 
     https://devcenter.heroku.com/articles/heroku-cli
* 登入 Heroku，輸入剛申請的帳號密碼。
  ```
  $ heroku login
  ```
* 創建一個新的 Heroku 應用
  ```
  $ heroku create
  ```
* 把專案推上 Heroku
  ```
  $ git push heroku master
  ```
* 用  Heroku 執行 rails db:migrate
  ```
  $ heroku run rails db:migrate
  ```



