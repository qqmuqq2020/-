<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${r"${"}pageContext.request.contextPath}"/>
<%
    response.setHeader("Access-Control-Allow-Origin", "*");
%>
<div class="row">
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
      <div class="x_title">
        <h2>添加${table.comment}</h2>
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
        <br />
        <form id="addForm" data-parsley-validate class="form-horizontal form-label-left">
            <#list table.cloumns as cloumn>
                <#if  cloumn.cloumnName!='id'>
                    <#if cloumn.comment?contains('select')>
                        <div class="form-group">
                            <label for="${cloumn.cloumnName}" class="col-md-3 col-sm-3 col-xs-12 control-label">${cloumn.comment?split(";")[0]}</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <select name="${cloumn.cloumnName}" id="${cloumn.cloumnName}" class="form-control col-md-7 col-xs-12">
                                    <#list cloumn.comment?split(";")[2]?split(",") as name>
                                        <option value="${name?split(":")[0]}">${name?split(":")[1]}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                    <#elseif cloumn.comment?contains('radio')>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 col-xs-12 control-label">${cloumn.comment?split(";")[0]}</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="radio">
                                    <#list cloumn.comment?split(";")[2]?split(",") as name>
                                        <label>
                                            <input type="radio"  value="${name?split(":")[0]}" id="${cloumn.cloumnName}${name_index}" name="${cloumn.cloumnName}">${name?split(":")[1]}
                                        </label>
                                    </#list>
                                </div>
                            </div>
                        </div>
                    <#elseif cloumn.comment?contains('checkbox')>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 col-xs-12 control-label">${cloumn.comment?split(";")[0]}</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="checkbox">
                                    <#list cloumn.comment?split(";")[2]?split(",") as name>
                                        <label>
                                            <input type="checkbox"  value="${name?split(":")[0]}" id="${cloumn.cloumnName}${name_index}" name="${cloumn.cloumnName}">${name?split(":")[1]}
                                        </label>
                                    </#list>
                                </div>
                            </div>
                        </div>
                    <#elseif cloumn.javaType=='Date'>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="creatdTime">${cloumn.comment}</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" id="${cloumn.cloumnName}" name="${cloumn.cloumnName}" required="required" class="form-control has-feedback-left">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                            </div>
                        </div>
                    <#elseif cloumn.cloumnType=='TEXT'>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="${cloumn.cloumnName}">${cloumn.comment}</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <textarea class="form-control" rows="5" id="${cloumn.cloumnName}" name="${cloumn.cloumnName}"></textarea>
                            </div>
                        </div>
                    <#else>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="${cloumn.cloumnName}">${cloumn.comment}</label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" id="${cloumn.cloumnName}" name="${cloumn.cloumnName}" required="required" class="form-control col-md-7 col-xs-12">
                            </div>
                        </div>
                    </#if>
                </#if>
            </#list>
          <div class="ln_solid"></div>
          <div class="form-group">
            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
              <button type="button" class="btn btn-primary" id="cancel">取消</button>
              <button type="button" class="btn btn-success" id="submit">添加</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script>
    $(function () {
<#list table.cloumns as cloumn>
    <#if cloumn.javaType=='Date'>
        $('#${cloumn.cloumnName}').daterangepicker({
            singleDatePicker: true,
            calender_style: "picker_2",
            format: 'YYYY-MM-DD'
        });
    </#if>
</#list>
    });
    $("#submit").click(function () {
    <#list table.cloumns as cloumn>
        <#if cloumn.comment?contains('checkbox')>
            var ${cloumn.cloumnName}=null;
            $('input[name="${cloumn.cloumnName}"]:checked').each(function(){
                ${cloumn.cloumnName}=${cloumn.cloumnName}+","+$(this).val();
            });
            ${cloumn.cloumnName}=${cloumn.cloumnName}+",";
        <#elseif cloumn.comment?contains('radio')>
            var ${cloumn.cloumnName}=$("input[name='${cloumn.cloumnName}']:checked").val();
        <#else>
            var ${cloumn.cloumnName}=$("#${cloumn.cloumnName}").val();
        </#if>
    </#list>
        var params={};
    <#list table.cloumns as cloumn>
        params['${cloumn.cloumnName}']=${cloumn.cloumnName};
    </#list>
        $.ajax({
          type: 'POST',
          url: '${r"${"}ctx}/client/${lowerClassName}/saveOrUpdate${table.className}',
          data: params,
          dataType:"json",
          success: function (result) {
              if(result.status==0){
                  alert({"title":"操作提示","content":"操作成功",ok:function(){
                      window.loadContent("${r"${"}ctx}/${lowerClassName}/${lowerClassName}List.jsp",null);
                  }});
              }else{
                  alert({"title":"操作提示","content":result.message});
              }
          }
      });
    });
  $("#cancel").click(function () {
      window.loadContent("${r"${"}ctx}/${lowerClassName}/${lowerClassName}List.jsp",null);
  });
</script>