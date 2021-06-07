<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, repo_name, twitter_handle, email, project_title, project_description
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">管货宝</h3>

  <p align="center">
  完全开源免费的零担(专线)物流业务管理软件
    <br />
    <a href="https://github.com/github_username/repo_name"><strong>浏览代码库»</strong></a>
    <br />
    <br />
    <a href="https://github.com/github_username/repo_name">系统演示</a>
    ·
    <a href="https://github.com/github_username/repo_name/issues">提交Bug</a>
    ·
    <a href="https://github.com/github_username/repo_name/issues">提交需求</a>
  </p>
</p>


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">目录</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">项目简介</a>
      <ul>
        <li><a href="#built-with">相关技术</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">如何运行系统</a>
      <ul>
        <li><a href="#prerequisites">准备工作</a></li>
        <li><a href="#installation">安装</a></li>
      </ul>
    </li>
    <li><a href="#usage">操作指南</a></li>
    <li><a href="#roadmap">研发路线图</a></li>
    <li><a href="#contributing">贡献代码</a></li>
    <li><a href="#license">授权</a></li>
    <li><a href="#contact">联系作者</a></li>
    <li><a href="#acknowledgements">相关术语</a></li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
##  1. <a name='about-the-project'></a>项目简介 

[![Product Name Screen Shot][product-screenshot]](https://example.com)

管货宝是功能完善的零担(专线)物流业务管理软件，功能涵盖运单处理、货物运输、运费货款管控、客户关系管理、公司分成核算等业务。
软件在多家物流公司应用，当前开源的是业务简化后的版本，去除了部分通用性不高的功能模块。

* 系统支持多分公司，多线路运营。
* 系统支持货场手持设备扫码分捡、装车。
* 系统包含PC端管理软件和手机APP。

###  1.1. <a name='built-with'></a>相关技术 

* [Ruby On Rails 3.2.7](https://rubyonrails.org/)

  正为升级至rails6做准备。

* [Ruby 1.9.3](https://www.ruby-lang.org/en/)

  正为升级至ruby2做准备。

* [MySql5.5](https://www.mysql.com/)
* [Lodop-票据及标签打印组件](http://www.lodop.net/) 


<!-- GETTING STARTED -->
##  2. <a name='getting-started'></a>如何运行系统 

通过Git获取将仓库代码clone到本地，以下介绍如何通过docker启动系统。


###  2.1. <a name='prerequisites'></a>准备工作 

* docker 

    代码仓库中有docker相关的配置文件，系统运行不需要其他的支撑软件，直接在docker虚拟机中运行。
    docker在不同操作系统中的安装，可参照官方文档进行。

    [docker的获取和安装，参看官方文档](https://docs.docker.com/get-docker/)

###  2.2. <a name='installation'></a>安装 

1. Clone代码仓库 
   ```sh
   git clone https://github.com/github_username/repo_name.git
   ```

2. Build docker镜像 
   ```sh
   docker compose build
   ```

3. 创建数据库 
    ```
    docker compose run web bundle exec rake db:create
    ```

4.  migrate数据库
    ```
    docker compose run web bundle exec rake db:migrate
    docker compose run web bundle exec rake db:convert_new_function_obj
    ```
5. 生成demo数据 
    ```
    docker compose run web bundle exec rake db:gen_test_data
    docker compose run web bundle exec rake db:create_user
    ```

6.  启动系统 
    ```
    docker compose up 
    ```

7.  登录系统 

    通过浏览器访问http://localhost:5003,登录系统

    用户名: admin

    密码:admin

<!-- USAGE EXAMPLES -->
##  3. <a name='usage'></a>操作指南 

操作手册完善中，可以参考[操作手册](https://example.com)_

<!-- ROADMAP -->
##  4. <a name='roadmap'></a>研发路线图 
1. 2021年10月底，将代码迁移至rails6.1版本
2. 2021年12月底，前端升级为hot wire技术
3. 2022年6月将前端app替换为react或vue技术栈


<!-- CONTRIBUTING -->
##  5. <a name='conributing'></a>贡献代码 

1. Fork项目
2. 创建自己的代码分支 (`git checkout -b feature/AmazingFeature`)
3. Commit变更(`git commit -m 'Add some AmazingFeature'`)
4. Push分支 (`git push origin feature/AmazingFeature`)
5. 请求代码合并



<!-- LICENSE -->
##  6. <a name='license'></a>授权 

基于MIT授权. 查看 `LICENSE` 了解更多信息.



<!-- CONTACT -->
##  7. <a name='contact'></a>联系开发者 

* 邮箱: [542340109@qq.com](mailto:542340109@qq.com) 
* 微信: 542340109

<!-- 打赏 -->
##  8. <a name='donate'></a>捐赠作者
给作者一些动力,帮他买一杯 :coffee:

<img src="alipy.JPG" alt="打赏" style="width:200px;"/>

<img src="wechat_pay.JPG" alt="打赏" style="width:200px;"/>

<!-- ACKNOWLEDGEMENTS -->
##  9. <a name='acknowledgements'></a>术语参考 
* [零担物流](https://baike.baidu.com/item/%E9%9B%B6%E6%8B%85%E7%89%A9%E6%B5%81)
* [专线物流](https://baike.baidu.com/item/%E4%B8%93%E7%BA%BF%E7%89%A9%E6%B5%81)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/github_username