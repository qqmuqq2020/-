package cn.${package}.beans;
import java.io.Serializable;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
/***
*   ${table.comment}
*/
public class ${table.className} implements Serializable {
        <#list table.cloumns as cloumn>
        //${cloumn.comment}
        private ${cloumn.javaType} ${cloumn.fieldName};
        </#list>
        //get set 方法
        <#list table.cloumns as cloumn>
            public void set${cloumn.upperCasecloumnName} (${cloumn.javaType}  ${cloumn.fieldName}){
                this.${cloumn.fieldName}=${cloumn.fieldName};
            }
            <#if cloumn.javaType=='Date'>
            @DateTimeFormat(pattern = "yyyy-MM-dd")
            </#if>
            public  ${cloumn.javaType} get${cloumn.upperCasecloumnName}(){
                return this.${cloumn.fieldName};
            }
        </#list>
}
