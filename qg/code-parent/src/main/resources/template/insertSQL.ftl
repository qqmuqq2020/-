INSERT INTO `zl`.`module` (
    `name`,
    `url`,
    `parent`,
    `creatdTime`,
    `updatedTime`,
    `status`
)
VALUES
(
    '${table.comment}',
    '/client/${lowerClassName}/${lowerClassName}List.jsp',
    '0',
    NULL,
    NULL,
    '0'
);
