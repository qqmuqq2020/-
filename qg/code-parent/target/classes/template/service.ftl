package cn.${package}.service.${lowerClassName};
import cn.${package}.beans.${table.className};
import java.util.Date;
import java.util.List;
import java.util.Map;
import cn.bdqn.common.Page;
/**
* Created by shang-pc on 2015/11/7.
*/
public interface ${table.className}Service {

    public ${table.className} get${table.className}ById(Long id)throws Exception;

    public List<${table.className}>	get${table.className}ListByMap(Map<String,Object> param)throws Exception;

    public Integer get${table.className}CountByMap(Map<String,Object> param)throws Exception;

    public Integer qdtxAdd${table.className}(${table.className} ${lowerClassName})throws Exception;

    public Integer qdtxModify${table.className}(${table.className} ${lowerClassName})throws Exception;

    public Integer qdtxDelete${table.className}ById(Long id)throws Exception;

    public Page<${table.className}> query${table.className}PageByMap(Map<String,Object> param,Integer pageNo,Integer pageSize)throws Exception;

    public Integer qdtxBatchDelete${table.className}(String ids)throws Exception;

}
