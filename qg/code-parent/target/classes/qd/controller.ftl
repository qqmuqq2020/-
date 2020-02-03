package com.${package}.controller;
import com.${package}.beans.${table.className};
import com.${package}.common.Constants;
import com.${package}.common.Page;
import com.${package}.common.ReturnResult;
import com.${package}.service.${lowerClassName}.${table.className}Service;
import com.${package}.util.EmptyUtils;
import com.${package}.util.ReturnResultUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.Map;
import com.${package}.util.MapUtil;
/**
 * Created by zezhong.shang on 17-10-16.
 */
@Controller
@RequestMapping("/client/${lowerClassName}")
public class ${table.className}Controller {

    @Autowired
    private ${table.className}Service ${lowerClassName}Service;

    @RequestMapping("/search")
    @ResponseBody
    public Page<${table.className}> search${table.className}(@RequestParam Map<String,Object> param) {
        Page<${table.className}> ${lowerClassName}Page = null;
        MapUtil.paramExecute(param);
        try {
            Integer pageNo= EmptyUtils.isEmpty(param.get("pageNo"))? Constants.DEFAULT_PAGE_NO:Integer.parseInt((String) param.get("pageNo"));
            Integer pageSize= EmptyUtils.isEmpty(param.get("pageSize"))? Constants.DEFAULT_PAGE_SIZE:Integer.parseInt((String) param.get("pageSize"));
            ${lowerClassName}Page  = ${lowerClassName}Service.query${table.className}PageByMap(param, pageNo, pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ${lowerClassName}Page;
    }

    @RequestMapping("/saveOrUpdate${table.className}")
    @ResponseBody
    public ReturnResult saveOrUpdate${table.className}(${table.className} ${lowerClassName}){
        Integer flag=0;
        try {
            if(EmptyUtils.isEmpty(${lowerClassName}.getId())){
                flag=${lowerClassName}Service.qdtxAdd${table.className}(${lowerClassName});
            }else{
                flag=${lowerClassName}Service.qdtxModify${table.className}(${lowerClassName});
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag>=1?ReturnResultUtil.returnSuccess():ReturnResultUtil.returnFail();
    }

    @RequestMapping("/get${table.className}ById")
    @ResponseBody
    public ReturnResult get${table.className}ById(Long id){
        ReturnResult result= ReturnResultUtil.returnSuccess();
        ${table.className} ${lowerClassName}=null;
        try {
            ${lowerClassName}=${lowerClassName}Service.get${table.className}ById(id);
            result.setData(${lowerClassName});
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/batchRemove${table.className}")
    @ResponseBody
    public ReturnResult batchRemove${table.className}(String ids){
        Integer flag=0;
        try {
            flag=${lowerClassName}Service.qdtxBatchDelete${table.className}(ids);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ReturnResultUtil.returnSuccess();
    }

    @RequestMapping("/remove${table.className}ById")
    @ResponseBody
    public ReturnResult remove${table.className}ById(Long id){
        Integer flag=0;
        try {
            flag=${lowerClassName}Service.qdtxDelete${table.className}ById(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ReturnResultUtil.returnSuccess();
    }
}
