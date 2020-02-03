package com.${package}.service.impl;
import com.${package}.mapper.${table.className}Mapper;
import com.${package}.bean.${table.className};
import com.${package}.service.${table.className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import com.dy.common.Page;
import com.dy.common.Constants;
import com.dy.util.EmptyUtils;
@Service
public class ${table.className}ServiceImpl implements ${table.className}Service {

    @Autowired
    private ${table.className}Mapper ${lowerClassName}Mapper;

    public ${table.className} get${table.className}ById(Long id)throws Exception{
        return ${lowerClassName}Mapper.get${table.className}ById(id);
    }

    public List<${table.className}>	get${table.className}ListByMap(Map<String,Object> param)throws Exception{
        return ${lowerClassName}Mapper.get${table.className}ListByMap(param);
    }

    public Integer get${table.className}CountByMap(Map<String,Object> param)throws Exception{
        return ${lowerClassName}Mapper.get${table.className}CountByMap(param);
    }

    public Integer qdtxAdd${table.className}(${table.className} ${lowerClassName})throws Exception{
            ${lowerClassName}.setCreatedTime(new Date());
            return ${lowerClassName}Mapper.insert${table.className}(${lowerClassName});
    }

    public Integer qdtxModify${table.className}(${table.className} ${lowerClassName})throws Exception{
        ${lowerClassName}.setUpdatedTime(new Date());
        return ${lowerClassName}Mapper.update${table.className}(${lowerClassName});
    }

    public Integer qdtxDelete${table.className}ById(Long id)throws Exception{
        return ${lowerClassName}Mapper.delete${table.className}ById(id);
    }

    public Integer qdtxBatchDelete${table.className}(String ids)throws Exception{
        Map<String,List<String>> param=new HashMap<String,List<String>>();
        String[] paramArrays=ids.split(",");
        List<String> idList=new ArrayList<String>();
            for (String temp:paramArrays){
                idList.add(temp);
            }
        param.put("ids",idList);
        return ${lowerClassName}Mapper.batchDelete${table.className}(param);
    }

    public Page<${table.className}> query${table.className}PageByMap(Map<String,Object> param,Integer pageNo,Integer pageSize)throws Exception{
        Integer total = ${lowerClassName}Mapper.get${table.className}CountByMap(param);
        pageNo = EmptyUtils.isEmpty(pageNo) ? Constants.DEFAULT_PAGE_NO : pageNo;
        pageSize = EmptyUtils.isEmpty(pageSize) ? Constants.DEFAULT_PAGE_SIZE : pageSize;
        Page page = new Page(pageNo, pageSize, total);
        param.put("beginPos", page.getBeginPos());
        param.put("pageSize", page.getPageSize());
        List<${table.className}> ${lowerClassName}List = ${lowerClassName}Mapper.get${table.className}ListByMap(param);
        page.setRows(${lowerClassName}List);
        return page;
     }


}
