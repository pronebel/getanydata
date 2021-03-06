<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="staticPath" value="${pageContext.request.contextPath}/static"/>

<html>
<head>
    <title>${projectName} - ${user.selfPathName} - GetAnyData</title>
    <link rel="stylesheet" type="text/css" media="screen" href="${staticPath}/css/editor.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${staticPath}/css/gfm.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${staticPath}/css/github.css" />
    <link rel="stylesheet" href="${staticPath}/codemirror/lib/codemirror.css">

    <script type="text/javascript" src="${staticPath}/prettify/prettify.js"></script>
    <script type="text/javascript" src="${staticPath}/scripts/marked.js"></script>
    <script type="text/javascript" src="${staticPath}/codemirror/lib/codemirror.js"></script>
    <script type="text/javascript" src="${staticPath}/codemirror/markdown.js"></script>
    <script>
        function chooseApi(type){
            $('#apiType').html($('#apiType-'+type).html());
            $('#apiTypeValue').val(type);
            $('#api-md-desc').show();
            $('#api-md-btn').show();
        }
    </script>
</head>

<body>

<div class="header">
    <div class="row">
        <div class="large-8 small-12 medium-8 columns">
            <div class="left">
                <h3>
                    <img src="${staticPath}/images/icon/http_icon.png" width="40" height="40" alt=""/>
                    <a href="${ctx}/${user.selfPathName}">
                        <b>${user.selfPathName}</b>
                    </a>
                    /
                    <a href="${ctx}/${user.selfPathName}/${project.name}">
                        <b>${project.name}</b>
                    </a>
                    <span data-tooltip aria-haspopup="true" class="has-tip" title="含收费项目."><i class="fi-yen"></i></span>
                   <span data-tooltip aria-haspopup="true" class="has-tip" title="私有项目."><i class="fi-lock"></i></span>
                    <c:forEach var="flag" items="${flags}">
                            <a class="tag-container" href="${ctx}/tags/${flag}">${flag}</a>
                    </c:forEach>
                </h3>
            </div>
        </div>
        <div class="large-4 small-12 medium-4 columns">
            <%--这里要用token防止重复提交--%>
            <div class="right">
                <a class="tag-container-tongji" href=""><i class="fi-star"></i> star <span
                        class="star-share-num">88890</span></a>
                <a class="tag-container-tongji" href=""><i class="fi-share"></i> share <span class="star-share-num">88110</span></a>

            </div>
        </div>

    </div>
</div>


<div class="row api-content">


    <div class="large-10 small-12 columns">
        <div class="row">
            <div class="large-10 columns">
                <p style="margin-top: 20px">${project.simpleInfo}</p>
            </div>
            <div class="large-2 columns">

                    <%--需要有用户权限--%>
                    <a href="javascript:void(0)" class="button secondary tiny">新增</a>
            </div>
        </div>

        <dl class="accordion" data-accordion>
            <c:forEach var="projectData" items="${project.projectDatas}">
            <dd class="accordion-navigation api-md-desc">
                <a href="#panel${projectData.id}b" id="api-desc-p-markdown-${projectData.id}"><span class="http-method-${projectData.apiType}">${projectData.apiType}</span><span class="http-api-desc">${projectData.apiName}</span></a>
                <div id="panel${projectData.id}b" class="content markdown">
                    <div id="api-markdown-preview-${projectData.id}" class="md-gfm markdown-preview editor-container">${projectData.apiContent}</div>
                </div>
            </dd>
            </c:forEach>
        </dl>

        <div class="row collapse prefix-radius">

            <div class="large-3 columns">
                <label for="apiType">接口描述类型</label>
                <button href="#" id="apiType" data-dropdown="apiType-dropdown" aria-controls="apiType-dropdown"
                        aria-expanded="false" class="button tiny success radius dropdown">选择接口类型</button><br>
                <ul id="apiType-dropdown" data-dropdown-content class="f-dropdown" aria-hidden="true">
                    <li><a href="javascript:chooseApi('POST')" id="apiType-POST">HTTP-POST</a></li>
                    <li><a href="javascript:chooseApi('GET')" id="apiType-GET">HTTP-GET</a></li>
                    <li><a href="javascript:chooseApi('PUT')" id="apiType-PUT">HTTP-PUT</a></li>
                    <li><a href="javascript:chooseApi('DELETE')" id="apiType-DELETE">HTTP-DELETE</a></li>
                </ul>
                <input type="hidden" id="apiTypeValue" name="apiType"/>
            </div>
            <div class="large-9 columns">
                <label for="apiName">接口名称</label>
                <input type="text" placeholder="接口名称" id="apiName" name="apiName" class="radius"/>
            </div>

        </div>
    </div>


    <div class="large-2 columns">
        <nav class="sunken-menu repo-nav"  >
            <ul class="sunken-menu-group">
                <li class="tooltipped tooltipped-w" >
                    <a href="/hardenCN/TulingJsonProcess" class="selected sunken-menu-item" >
                        <span class="fi-info"></span><span class="full-word">详情</span>
                    </a>    </li>
                <li class="tooltipped tooltipped-w" >
                    <a href="${ctx}/hardenCN/酒店订单接口/issues" class="sunken-menu-item" >
                        <span class="fi-alert"></span><span class="full-word">反馈</span>
                        <span class="counter">0</span>
                    </a>      </li>
                <li class="tooltipped tooltipped-w">
                    <a href="/hardenCN/TulingJsonProcess/graphs"  class="sunken-menu-item" >
                        <span class="fi-graph-bar"></span><span class="full-word">统计</span>
                    </a>    </li>
            </ul>

            <shiro:authenticated>
            <div class="sunken-menu-separator"></div>
            <ul class="sunken-menu-group">
                <li class="tooltipped tooltipped-w">
                    <a href="/hardenCN/TulingJsonProcess/settings"  class="sunken-menu-item" >
                        <i class="fi-wrench"></i> <span class="full-word">设置</span>
                    </a>      </li>
            </ul>
            </shiro:authenticated>
        </nav>
    </div>

</div>


<hr class="large-10 small-12 medium-10 columns large-centered small-centered medium-centered"
    style="margin-top: 50px;padding-bottom: 20px"/>

<script>
    $(".markdown-preview").html(marked.parser(marked.lexer($(".markdown-preview").text())))
</script>
</body>
</html>