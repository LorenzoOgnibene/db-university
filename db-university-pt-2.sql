-- 1. Contare quanti iscritti ci sono stati ogni anno

    SELECT COUNT(*) AS `numero_studenti`, YEAR(`enrolment_date`) AS `anno_iscrizione`
    FROM `students`
    GROUP BY `anno_iscrizione`;
    
-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
    
    SELECT COUNT(*), `office_address`
    FROM `teachers`
    GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame

    SELECT `exam_id` AS `id_appello`, AVG(`vote`) AS `media_voti`
    FROM `exam_student`
    GROUP BY `id_appello`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

    SELECT `department_id`, COUNT(*) AS `corsi`
    FROM `degrees`
    GROUP BY `department_id`;

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

    SELECT `students`.`name`, `students`.`surname`, `students`.`registration_number` , `degrees`.`name`
    FROM `students`
    JOIN `degrees`
    ON `students`.`degree_id` = `degrees`.`id`
    WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

    SELECT `degrees`.`name` AS `nome_corso`, `departments`.`name` AS `nome_dipartimento`, `degrees`.`level` AS `grado_corso`
    FROM `degrees`
    JOIN `departments`
    ON `degrees`.`department_id` = `departments`.`id`
    WHERE `degrees`.`level`  = 'magistrale' && `departments`.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

    SELECT * 
    FROM `teachers`

    JOIN `course_teacher`
    ON `course_teacher`.`course_id` = `teachers`.`id`

    JOIN `courses`
    ON `courses`.`id` = `course_teacher`.`course_id`

    WHERE `teachers`.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

    SELECT `students`.`surname`, `students`.`name`, `degrees`.`name`, `departments`.`name`
    FROM `students`

    JOIN `degrees`
    ON `degrees`.`id` = `students`.`degree_id`

    JOIN `departments`
    ON `departments`.`id` = `degrees`.`department_id`

    ORDER BY CONVERT(`students`.`surname` USING utf8) COLLATE utf8_general_ci;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

    SELECT `teachers`.`name`, `teachers`.`surname`, `degrees`.`name`, `degrees`.`level`, `courses`.`year` , `courses`.`period`, `courses`.`cfu`
    FROM `teachers`

    JOIN `course_teacher`
    ON `course_teacher`.`teacher_id` = `teachers`.`id`

    JOIN `courses`
    ON `courses`.`id` = `course_teacher`.`course_id`

    JOIN `degrees`
    ON `degrees`.`id`= `courses`.`degree_id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

    SELECT DISTINCT `teachers`.`name`, `teachers`.`surname`
    FROM `departments`

    JOIN `degrees`
    ON `degrees`.`department_id` = `departments`.`id`

    JOIN `courses`
    ON `courses`.`degree_id` = `degrees`.`id`

    JOIN `course_teacher`
    ON `course_teacher`.`course_id` = `courses`.`id`

    JOIN `teachers`
    ON `teachers`.id = `course_teacher`.`teacher_id`

    WHERE `departments`.`name` = 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami