package com.${package}.service.impl;
import com.${package}.mapper.${table.className}Mapper;
import com.${package}.pojo.${table.className};
import com.${package}.service.${table.className}Service;
import com.alibaba.dubbo.config.annotation.Service;
import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

@Component
@Service(interfaceClass=${table.className}Service.class)
public class ${table.className}ServiceImpl implements ${table.className}Service {

    @Resource
    private ${table.className}Mapper ${lowerClassName}Mapper;

    public ${table.className} get${table.className}ById(String id)throws Exception{
        return ${lowerClassName}Mapper.get${table.className}ById(id);
    }

    public List<${table.className}>	get${table.className}ListByMap(Map<String,Object> param)throws Exception{
        return ${lowerClassName}Mapper.get${table.className}ListByMap(param);
    }

    public Integer get${table.className}CountByMap(Map<String,Object> param)throws Exception{
        return ${lowerClassName}Mapper.get${table.className}CountByMap(param);
    }

    public Integer qdtxAdd${table.className}(${table.className} ${lowerClassName})throws Exception{
            //${lowerClassName}.setCreatedTime(new Date());
            return ${lowerClassName}Mapper.insert${table.className}(${lowerClassName});
    }

    public Integer qdtxModify${table.className}(${table.className} ${lowerClassName})throws Exception{
        //${lowerClassName}.setUpdatedTime(new Date());
        return ${lowerClassName}Mapper.update${table.className}(${lowerClassName});
    }

    public Integer qdtxDelete${table.className}ById(String id)throws Exception{
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


}
