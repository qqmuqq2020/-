package com.code.handler;

import com.code.bean.Table;
import com.code.constant.Constant;
import com.code.util.FreeMarkerUtils;
import com.code.util.StringUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zezhong.shang on 17-6-5.
 */
public class MvcHandler {

    String templateFile = Constant.template_path;

    public void executeModule(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "qg");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = table.getClassName() + ".java";
        String savePath = Constant.model_save_path;
        String templateName = "model";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeService(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "qg");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = table.getClassName() + "Service" + ".java";
        String savePath = Constant.service_save_path + "//";
        String templateName = "service";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeServiceImpl(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "qg");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = table.getClassName() + "ServiceImpl" + ".java";
        String savePath = Constant.service_impl_save_path + "//";
        String templateName = "serviceImpl";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeMapper(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "qg");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = table.getClassName() + "Mapper" + ".xml";
        String savePath = Constant.mapper_save_path + "//";
        String templateName = "mapper";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeClazzMapper(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "qg");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = table.getClassName() + "Mapper" + ".java";
        String savePath = Constant.class_mapper_save_path +"//";
        String templateName = "clazzMapper";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeController(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "dy");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = table.getClassName() + "Controller" + ".java";
        String savePath = Constant.controller_save_path +"//";
        String templateName = "controller";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeAddJsp(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "dy");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = "add"+table.getClassName()+".jsp";
        String savePath = Constant.jsp_save_path +"//"+StringUtils.lowerName(table.getClassName())+"//";
        String templateName = "jsp-add";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeUpdateJsp(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "dy");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = "update"+table.getClassName()+".jsp";
        String savePath = Constant.jsp_save_path +"//"+StringUtils.lowerName(table.getClassName())+"//";
        String templateName = "jsp-update";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeListJsp(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("package", "dy");
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName = StringUtils.lowerName(table.getClassName())+"List.jsp";
        String savePath = Constant.jsp_save_path +"//"+StringUtils.lowerName(table.getClassName())+"//";
        String templateName = "jsp-list";
        FreeMarkerUtils.genteratorFile(input, templateFile, templateName, savePath, fileName);
    }

    public void executeMenu(Table table) {
        Map input = new HashMap();
        input.put("table", table);
        input.put("lowerClassName", StringUtils.lowerName(table.getClassName()));
        String fileName ="insertSQL.sql";
        String savePath = Constant.sql_save_path;
        String templateName = "insertSQL";
        FreeMarkerUtils.appendgenteratorFile(input, templateFile, templateName, savePath, fileName);
    }
}
