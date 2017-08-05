/*
* Copyright 2017 Philipp Salvisberg <philipp.salvisberg@trivadis.com>
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

CREATE OR REPLACE VIEW plscope_statements AS
SELECT owner, 
       signature, 
       type, 
       object_name, 
       object_type, 
       usage_id, 
       line, 
       col, 
       usage_context_id, sql_id,
       CASE 
          WHEN (count(sql_id) OVER (PARTITION BY sql_id)) > 1 THEN 
             'YES'
          ELSE 
             'NO' 
       END AS is_duplicate,
       has_hint, 
       has_into_bulk, 
       has_into_returning, 
       has_into_record, 
       has_current_of, 
       has_for_update,
       has_in_binds, 
       text, 
       full_text, 
       origin_con_id
  FROM dba_statements stmt
 WHERE owner LIKE nvl(sys_context('PLSCOPE', 'OWNER'), USER);
