//
//  QuestionBank.swift
//  Quizzler
//
//  Created by Angela Yu on 26/08/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import Foundation

class QuestionBank {
    
    var list = [Question]()
    
    init() {
        list.append(Question("Tristeza",["0 No me siento triste.",
            "1 Me siento triste gran parte del tiempo.",
            "2 Me siento triste todo el tiempo.",
            "3 Me siento tan triste o soy tan infeliz que no puedo soportarlo."]))
        list.append(Question("Pesimismo",["0 No estoy desalentado respecto del mi futuro.",
                                         "1 Me siento más desalentado respecto de mi futuro que lo que solía estarlo.",
                                         "2 No espero que las cosas funcionen para mi.",
                                         "3 Siento que no hay esperanza para mi futuro y que sólo puede empeorar."]))
        list.append(Question("Fracaso",["0 No me siento como un fracasado.",
                                           "1 He fracasado más de lo que hubiera debido.",
                                           "2 Cuando miro hacia atrás, veo muchos fracasos.",
                                           "3 Siento que como persona soy un fracaso total."]))
        list.append(Question("4. Pérdida de Placer",["0 Obtengo tanto placer como siempre por las cosas de las que disfruto.",
                                        "1 No disfruto tanto de las cosas como solía hacerlo.",
                                        "2 Obtengo muy poco placer de las cosas que solía disfrutar.",
                                        "3 No puedo obtener ningún placer de las cosas de las que solía disfrutar."]))
        list.append(Question("5. Sentimientos de Culpa",["0 No me siento particularmente culpable.",
                                                         "1 Me siento culpable respecto de varias cosas que he hecho o que debería haber hecho.",
                                                      "2 Me siento bastante culpable la mayor parte del tiempo.",
                                                      "3 Me siento culpable todo el tiempo."]))
        list.append(Question("6. Sentimientos de Castigo ",["0 No siento que esté siendo castigado",
                                                         "1 Siento que tal vez pueda ser castigado.",
                                                         "2 Espero ser castigado.",
                                                         "3 Siento que estoy siendo castigado."]))
        list.append(Question("7. Disconformidad con uno mismo ",["0 Siento acerca de mí lo mismo que siempre.",
                                                            "1 He perdido la confianza en mí mismo.",
                                                            "2 Estoy decepcionado conmigo mismo.",
                                                            "3 No me gusto a mí mismo."]))
        list.append(Question("8. Autocrítica  ",["0 No me critico ni me culpo más de lo habitual",
                                                                 "1 Estoy más crítico conmigo mismo de lo que solía estarlo",
                                                                 "2 Me critico a mí mismo por todos mis errores",
                                                                 "3 Me culpo a mí mismo por todo lo malo que sucede."]))
        list.append(Question("Pensamientos o Deseos Suicidas",["0 No tengo ningún pensamiento de matarme.",
                                                  "1 He tenido pensamientos de matarme, pero no lo haría",
                                                  "2 Querría matarme",
                                                  "3 Me mataría si tuviera la oportunidad de hacerlo."]))
        list.append(Question("Llanto",["0 No lloro más de lo que solía hacerlo.",
                                                               "1 Lloro más de lo que solía hacerlo",
                                                               "2 Lloro por cualquier pequeñez.",
                                                               "3 Siento ganas de llorar pero no puedo."]))
        list.append(Question("Agitación",["0 No estoy más inquieto o tenso que lo habitual.",
                                       "1 Me siento más inquieto o tenso que lo habitual.",
                                       "2 Estoy tan inquieto o agitado que me es difícil quedarme quieto",
                                       "3 Estoy tan inquieto o agitado que tengo que estar siempre en movimiento o haciendo algo."]))
        list.append(Question("Pérdida de Interés",["0 No he perdido el interés en otras actividades o personas.",
                                           "1 Estoy menos interesado que antes en otras personas o cosas.",
                                           "2 He perdido casi todo el interés en otras personas o cosas.",
                                           "3.Me es difícil interesarme por algo."]))
        list.append(Question("Indecisión",["0 Tomo mis propias decisiones tan bien como siempre.",
                                                     "1 Me resulta más difícil que de costumbre tomar decisiones",
                                                     "2 Encuentro mucha más dificultad que antes para tomar decisiones.",
                                                     "3 Tengo problemas para tomar cualquier decisión."]))
        list.append(Question("Desvalorización",["0 No siento que yo no sea valioso",
                                            "1 No me considero a mí mismo tan valioso y útil como solía considerarme",
                                            "2 Me siento menos valioso cuando me comparo con otros.",
                                            "3 Siento que no valgo nada."]))
        list.append(Question("Desvalorización",["0 No siento que yo no sea valioso",
                                                 "1 No me considero a mí mismo tan valioso y útil como solía considerarme",
                                                 "2 Me siento menos valioso cuando me comparo con otros.",
                                                 "3 Siento que no valgo nada."]))
        list.append(Question("Pérdida de Energía",["0 Tengo tanta energía como siempre.",
                                                 "1. Tengo menos energía que la que solía tener.",
                                                 "2. No tengo suficiente energía para hacer demasiado",
                                                 "3. No tengo energía suficiente para hacer nada."]))
        list.append(Question("Cambios en los Hábitos de Sueño",["0 No he experimentado ningún cambio en mis hábitos de sueño.",
                                                     "1. Duermo más / menos de lo habitual",
                                                     "2. Duermo mucho más / menos de lo habitual",
                                                     "3. Duermo la mayor parte del día / Me despierto 1-2h más temprano y no puedo volver a dormirme"]))
        list.append(Question("Irritabilidad",["0 No estoy tan irritable que lo habitual.","1 Estoy más irritable que lo habitual.","2 Estoy mucho más irritable que lo habitual.","3 Estoy irritable todo el tiempo."]))
        list.append(Question("Cambios en el Apetito",["0 No he experimentado ningún cambio en mi apetito.","1ª Mi apetito es un poco menor / mayor que lo habitual.","2a Mi apetito es mucho menor / mayor que antes.","3ª No tengo apetito en absoluto / Quiero comer todo el día"]))
         list.append(Question("Dificultad de Concentración ",["0 Puedo concentrarme tan bien como siempre.","1 No puedo concentrarme tan bien como habitualmente","2 Me es difícil mantener la mente en algo por mucho tiempo.","3 Encuentro que no puedo concentrarme en nada."]))
        list.append(Question("Cansancio o Fatiga ",["0 No estoy más cansado o fatigado que lo habitual.","1 Me fatigo o me canso más fácilmente que lo habitual.","2 Estoy demasiado fatigado o cansado para hacer muchas de las cosas que solía hacer.","3 Estoy demasiado fatigado o cansado para hacer la mayoría de las cosas que solía hacer."]))
        list.append(Question("Pérdida de Interés en el Sexo",["0 No he notado ningún cambio reciente en mi interés por el sexo.","1 Estoy menos interesado en el sexo de lo que solía estarlo.","2 Estoy mucho menos interesado en el sexo.","3 He perdido completamente el interés en el sexo."]))
    }
    
}


