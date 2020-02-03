<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${r"${"}pageContext.request.contextPath}"/>
<%
    response.setHeader("Access-Control-Allow-Origin", "*");
%>
<div class="">
  <div class="x_panel">
    <div class="x_title">
      <h2>${table.comment}列表</h2>
      <ul class="nav navbar-right panel_toolbox">
        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
        </li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">Settings 1</a>
            </li>
            <li><a href="#">Settings 2</a>
            </li>
          </ul>
        </li>
        <li><a class="close-link"><i class="fa fa-close"></i></a>
        </li>
      </ul>
      <div class="clearfix"></div>
    </div>
    <div class="x_content">
        <form class="form-horizontal form-label-left input_mask" role="form">
            <div class="form-group">
                <#list table.cloumns as cloumn>
                    <#if  cloumn.cloumnName!='id' && !cloumn.comment?contains('checkbox')>
                        <#if cloumn.comment?contains('select') || cloumn.comment?contains('radio')>
                            <div class="col-md-3 col-sm-3 col-xs-12 form-group">
                                <label for="${cloumn.cloumnName}">${cloumn.comment?split(";")[0]}</label>
                                    <select name="${cloumn.cloumnName}" id="${cloumn.cloumnName}" class="select2_single form-control">
                                        <option value="-1">请选择</option>
                                        <#list cloumn.comment?split(";")[2]?split(",") as name>
                                            <option value="${name?split(":")[0]}">${name?split(":")[1]}</option>
                                        </#list>
                                    </select>
                            </div>
                        <#elseif cloumn.javaType=='Date'>
                            <div class="col-md-3 col-sm-3 col-xs-12 form-group">
                                <label for="${cloumn.cloumnName}">${cloumn.comment}</label>
                                <input type="text" id="${cloumn.cloumnName}" name="${cloumn.cloumnName}" required="required" class="form-control">
                            </div>
                        <#else>
                            <div class="col-md-3 col-sm-3 col-xs-12 form-group">
                                <label for="${cloumn.cloumnName}">${cloumn.comment}</label>
                                <input type="text" class="form-control" id="${cloumn.cloumnName}" name="${cloumn.cloumnName}" placeholder="请输入${cloumn.comment}">
                            </div>
                        </#if>
                    </#if>
                </#list>
            </div>
        </form>
      <div class="form-inline pull-left">
        <div class="form-group" style="margin-left: 5px;">
          <button type="button" class="btn btn-primary" id="search">搜索</button>
          <button type="button" class="btn btn-info" id="add">新增</button>
          <button type="button" class="btn btn-danger" id="remove">删除</button>
        </div>
      </div>
      <table id="table"></table>
    </div>
  </div>
</div>
<script>
    <#list table.cloumns as cloumn>
        <#if cloumn.javaType=='Date'>
        $('#${cloumn.cloumnName}').daterangepicker({
            singleDatePicker: true,
            calender_style: "picker_2",
            format: 'YYYY-MM-DD'
        });
        </#if>
    </#list>
   var table=$('#table').bootstrapTable({
        url: '${r"${"}ctx}/client/${lowerClassName}/search',
        sidePagination:"server",
        pageList: [10, 25, 50, 100],
        pageNumber: 1, //初始化加载第一页，默认第一页
        pagination:true,//是否分页
        queryParamsType:'limit',//查询参数组织方式
        pageSize:10,//单页记录数
        pageList:[5,10,20,30],//分页步进值
        clickToSelect: true,//是否启用点击选中行
        toolbarAlign:'right',//工具栏对齐方式
        buttonsAlign:'right',//按钮对齐方式
        showColumns:true,
        showRefresh:true,
        searchAlign:'right',
        checkboxHeader:true,
        columns: [{
            checkbox:true,
            clickToSelect:true,
        },
<#list table.cloumns as cloumn>
<#if  cloumn.cloumnName!='id'>
    <#if cloumn.comment?contains('select') || cloumn.comment?contains('radio')>
        {
            field: '${cloumn.cloumnName}',
            title: '${cloumn.comment?split(";")[0]}',
            formatter:function (value,row,index) {
                <#list cloumn.comment?split(";")[2]?split(",") as name>
                    if(value=='${name?split(":")[0]}'){
                        return '${name?split(":")[1]}';
                    }
                </#list>
            }
        },
    <#elseif cloumn.comment?contains('checkbox')>
        {
            field: '${cloumn.cloumnName}',
            title: '${cloumn.comment?split(";")[0]}',
            formatter:function (value,row,index) {
                var temp="[";
                <#list cloumn.comment?split(";")[2]?split(",") as name>
                    if((value+"").indexOf(',${name?split(":")[0]},')>=0){
                        if(temp=='['){
                            temp=temp+'${name?split(":")[1]}';
                        }else{
                            temp=temp+'|${name?split(":")[1]}';
                        }
                    }
                </#list>
                temp=temp+']';
                return temp;
            }
        },
    <#else>
        {
            field: '${cloumn.cloumnName}',
            title: '${cloumn.comment}'
        },
    </#if>
</#if>
</#list>
        {
            title: '操作',
            width:"200px",
            formatter:function (value,row,index) {
                var edit="<a href='#' class='btn btn-info btn-xs' onclick=\"edit${table.className}('"+row.id+"')\"><i class='fa fa-pencil'></i> 编辑 </a>";
                var del="<a href='#' class='btn btn-danger btn-xs' onclick=\"remove${table.className}('"+row.id+"')\"><i class='fa fa-trash-o'></i> 删除 </a>";
                return edit+del;
            }
        }],
        queryParams: function queryParams(params) {  //设置查询参数
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                pageSize: params.limit,   //页面大小
                pageNo:(params.offset/params.limit)+1,
                sortOrder: params.order,
                <#list table.cloumns as cloumn>
                    <#if cloumn_has_next>
                        <#if  cloumn.cloumnName!='id'>
                            ${cloumn.cloumnName}:$("#${cloumn.cloumnName}").val(),
                        </#if>
                    <#else>
                        <#if  cloumn.cloumnName!='id'>
                            ${cloumn.cloumnName}:$("#${cloumn.cloumnName}").val()
                        </#if>
                    </#if>
                </#list>
            };
            return temp;
        },
        responseHandler:function (res) {
            return {"rows":res.rows,"total":res.total};
        },
    });
   $("#search").click(function () {
       $('#table').bootstrapTable('refresh', null);
   });
   $("#add").click(function () {
       window.loadContent("${r"${"}ctx}/${lowerClassName}/add${table.className}.jsp",null);
   });
   $("#remove").click(function () {
      var ids="";
      var selectItems=$('#table').bootstrapTable('getSelections', null);
      for (var i=0;i<selectItems.length;i++){
          ids=ids+","+selectItems[i].id;
      }
      if(ids==''){
          alert({"title":"提示","content":"请选择要删除的数据"});
      }else{
          confirm({
              title:"批量删除确认",
              content:"请确认是否要执行批量删除操作？",
              ok:function () {
                  $.ajax({
                      type: 'POST',
                      url: '${r"${"}ctx}/client/${lowerClassName}/batchRemove${table.className}',
                      data: {ids:ids},
                      dataType:"json",
                      success: function (result) {
                          if(result.status=="0"){
                              $('#table').bootstrapTable('refresh', null);
                          }else{
                              alert({
                                  title:"操作提示",
                                  content:result.message
                              })
                          }
                      }
                  });
              },
          });
      }
   });
   //查看关键词
   function view${table.className}(content) {
       dialog({
           width:"606px",
           height:"200px",
           content:content
       });
   }
   //编辑关键词
   function edit${table.className}(id) {
       window.loadContent("${r"${"}ctx}/${lowerClassName}/update${table.className}.jsp?id="+id,null);
   }
   //删除关键词
   function remove${table.className}(id) {
       confirm({
           title:"删除关键词提示",
           content:"请确认是否删除${table.comment}信息?",
           ok:function () {
               $.ajax({
                   type: 'POST',
                   url: '${r"${"}ctx}/client/${lowerClassName}/remove${table.className}ById',
                   data: {id:id},
                   dataType:"json",
                   success: function (result) {
                       if(result.status=="0"){
                           $('#table').bootstrapTable('refresh', null);
                       }else{
                           alert({"title":"删除提示","content":result.message});
                       }
                   }
               });
           }
       });
   }
</script>