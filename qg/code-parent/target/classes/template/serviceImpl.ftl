package cn.${package}.service.${lowerClassName}.impl;
import cn.${package}.dao.${lowerClassName}.${table.className}Mapper;
import cn.${package}.beans.${table.className};
import org.springframework.stereotype.Service;
import cn.${package}.service.${lowerClassName}.${table.className}Service;
import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;
import cn.bdqn.common.Page;
import cn.bdqn.common.Constants;
import cn.bdqn.util.EmptyUtils;
import cn.bdqn.common.Page;
import java.util.ArrayList;
import java.util.HashMap;

@Service
public class ${table.className}ServiceImpl implements ${table.className}Service {

    @Resource
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
            //${lowerClassName}.setCreatedTime(new Date());
            return ${lowerClassName}Mapper.insert${table.className}(${lowerClassName});
    }

    public Integer qdtxModify${table.className}(${table.className} ${lowerClassName})throws Exception{
        //${lowerClassName}.setUpdatedTime(new Date());
        return ${lowerClassName}Mapper.update${table.className}(${lowerClassName});
    }

    public Integer qdtxDelete${table.className}ById(Long id)throws Exception{
        return ${lowerClassName}Mapper.delete${table.className}ById(id);
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
