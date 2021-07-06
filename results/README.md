# Resultados Euroc V1_01 ORB_SLAM3 + GPS (Vicon)
GPS sin ruido gaussiano.
Pruebas realizadas en el cluster CCT.

**NOTA:** el Vicon de Euroc tiene una mayor frecuencia que el VIO que utilizaremos en las siguientes pruebas.
Como hay más mediciones del Vicon, podría llegar a pasar que va a hacer más correcciones el GPS que el VIO.
Pero, por defecto, MSF le limita la frecuencia al Vicon:
`Measurement throttling is on, dropping every but the 5th message` 

**ORB-SLAM3 tiene problemas al inicio, y en los metros iniciales devuelve una mala estimación, pero para el resto de la trayectoria presenta una buena estimación. En los resultados mostrados a continuación está incluido ese error en el inicio, así que se pueden llegar a sacar conclusiones erróneas acerca de la precisión de ORB-SLAM3. De todas formas hay que mencionar que esa mala estimación inicial también impacta en los resultados mostrados de MSF, ya que las poses de ORB-SLAM3 son entrada para el update de MSF.**

## Params

 * core_noise_*: noise parameters de la IMU
 * pose_noise_meas_p: Covarianza de ORB_SLAM3
 * pose_noise_meas_q: Covarianza de ORB_SLAM3
 * position_noise_meas: Covarianza del GPS

fuzzythres: Given that the vision-measurement might not always be expressed in frame of reference
which is gravity aligned, we estimate the rotation between the frame of reference of the
vision measurements and the world frame of reference. This rotation estimate might change
slowly over time, while large changes in this orientation estimate are usually a sign of
a failure in the visual SLAM module. We therefore watch the rate of change on this
estimate and trigger a warning message when the rate of change exceeds 0.1 rad/update.
We then drop the update of the EKF and due pure IMU dead-reckoning (forward integration).


### Parámetros utilizados
Parámetros folder 1/

 * fuzzythres = 0.1
 * /msf_position_pose_sensor/core/core_noise_acc: 0.016
 * /msf_position_pose_sensor/core/core_noise_accbias: 0.001
 * /msf_position_pose_sensor/core/core_noise_gyr: 0.000282
 * /msf_position_pose_sensor/core/core_noise_gyrbias: 0.0001
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_p: 0.01
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_q: 0.02
 * /msf_position_pose_sensor/position_pose_sensor/position_noise_meas: 0.1

Parámetros folder 2/
Igual que 1/, pero aumenta fuzzythres

 * fuzzythres = 0.2
 * /msf_position_pose_sensor/core/core_noise_acc: 0.016
 * /msf_position_pose_sensor/core/core_noise_accbias: 0.001
 * /msf_position_pose_sensor/core/core_noise_gyr: 0.000282
 * /msf_position_pose_sensor/core/core_noise_gyrbias: 0.0001
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_p: 0.01
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_q: 0.02
 * /msf_position_pose_sensor/position_pose_sensor/position_noise_meas: 0.1

Parámetros folder 3/
Igual que 2/, pero aumenta covarianza de ORB_SLAM3 y disminuye covarianza del Vicon

 * fuzzythres = 0.2
 * /msf_position_pose_sensor/core/core_noise_acc: 0.016
 * /msf_position_pose_sensor/core/core_noise_accbias: 0.001
 * /msf_position_pose_sensor/core/core_noise_gyr: 0.000282
 * /msf_position_pose_sensor/core/core_noise_gyrbias: 0.0001
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_p: 0.5
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_q: 0.5
 * /msf_position_pose_sensor/position_pose_sensor/position_noise_meas: 0.01

Parámetros folder 4/
Igual que 2/, pero solamente disminuye covarianza del Vicon (sin tocar covarianza de ORB-SLAM3)

 * fuzzythres = 0.2
 * /msf_position_pose_sensor/core/core_noise_acc: 0.016
 * /msf_position_pose_sensor/core/core_noise_accbias: 0.001
 * /msf_position_pose_sensor/core/core_noise_gyr: 0.000282
 * /msf_position_pose_sensor/core/core_noise_gyrbias: 0.0001
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_p: 0.01
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_q: 0.02
 * /msf_position_pose_sensor/position_pose_sensor/position_noise_meas: 0.01

Parámetros folder 5/
Igual que 2/

 * fuzzythres = 0.2
 * /msf_position_pose_sensor/core/core_noise_acc: 0.016
 * /msf_position_pose_sensor/core/core_noise_accbias: 0.001
 * /msf_position_pose_sensor/core/core_noise_gyr: 0.000282
 * /msf_position_pose_sensor/core/core_noise_gyrbias: 0.0001
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_p: 0.01
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_q: 0.02
 * /msf_position_pose_sensor/position_pose_sensor/position_noise_meas: 0.1

Parámetros folder 6/
Igual que 4/ pero aumenta noise params de la IMU

 * fuzzythres = 0.2
 * /msf_position_pose_sensor/core/core_noise_acc: 0.16
 * /msf_position_pose_sensor/core/core_noise_accbias: 0.01
 * /msf_position_pose_sensor/core/core_noise_gyr: 0.0282
 * /msf_position_pose_sensor/core/core_noise_gyrbias: 0.01
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_p: 0.01
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_q: 0.02
 * /msf_position_pose_sensor/position_pose_sensor/position_noise_meas: 0.01

### Resultados

*/vo_trajectory.txt: salida de ORB-SLAM3
*/msf_after_upd_trajectory.txt: salida de MSF, luego de hacer el update (esta es la que nos interesaría)
*/msf_odom_trajectory.txt: salida de MSF, después de hacer la prediction/propagation (es decir, esta salida se publica al rate de la IMU)

RMSE APE
|Experiment| ORB-SLAM3 | MSF (ORB-SLAM3 + Vicon) |
|--|--|--|
| 1 | 0.555162 | 1.151503 |
| 2 | 0.304429 | 1.087379 |
| 3 | 0.152002 | 0.249250 |
| 4 | 0.369549 | 0.181134 |
| 5 | 0.124237 | 1.038978 |
| 6 | 0.418753 | 0.146044 |

RMSE RPE
|Experiment| ORB-SLAM3 | MSF (ORB-SLAM3 + Vicon) |
|--|--|--|
| 1 | 0.044307 | 0.025934 |
| 2 | 0.043379 | 0.022333 | 
| 3 | 0.040037 | 0.036744 | 
| 4 | 0.041740 | 0.030339 |
| 5 | 0.035545 | 0.021314 |
| 6 | 0.045761 | 0.074080 |

Lo destacable es que cuando se disminuyó la covarianza del Vicon la estimación mejoró (plotear los resultados y observar).
No hay cambios sobre la configuración de ORB-SLAM3, por lo tanto llama la atención que retorne valores distintos para el APE en los distintos experimentos. Hay que realizar múltiples corridas con la misma configuración para ver esta diferencia entre los resultados de ORB-SLAM3 no influya.

Corremos varias veces con la configuración 4/

RMSE APE
|Experiment| ORB-SLAM3 | MSF (ORB-SLAM3 + Vicon) |
|--|--|--|
| 4_1 | 1.403031 | 0.537628 |
| 4_2 | 0.428174 | 0.186409 |
| 4_3 | 1.409926 | 0.592943 |
| 4_4 | 0.320560 | 0.244030 |

Como puede verse, los resultados de correr ORB-SLAM3 son dispares. A continuación, a partir de la configuración 4/, se aumenta bastante la covarianza de ORB-SLAM3, para que ver cómo impacta:

 * /msf_position_pose_sensor/core/core_noise_acc: 0.016
 * /msf_position_pose_sensor/core/core_noise_accbias: 0.001
 * /msf_position_pose_sensor/core/core_noise_gyr: 0.000282
 * /msf_position_pose_sensor/core/core_noise_gyrbias: 0.0001
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_p: 0.7
 * /msf_position_pose_sensor/pose_sensor/pose_noise_meas_q: 0.7
 * /msf_position_pose_sensor/position_pose_sensor/position_noise_meas: 0.01

Se realizan 4 corridas.

RMSE APE
|Experiment| ORB-SLAM3 | MSF (ORB-SLAM3 + Vicon) |
|--|--|--|
| 7_1 | 16.844196 | 1.524628 |
| 7_2 | 0.367932 | 0.290706 |
| 7_3 | 0.207632 | 0.250567|
| 7_4 | 0.137395 | 0.223075 |

Ploteando la salida de ORB-SLAM3 para 7_1, queda en evidencia que ORB-SLAM3 acumula mucho error al inicio. Pero si se ignora el inicio, el resto de la trayectoria de 7_1 es muy buena. **Por lo tanto, hay que tener cuidado los resultados expuestos aquí, ya que habría que revisar cómo impacta ese error en el inicio de la trayectoria estimada por ORB-SLAM3**

### Update
Para las carpetas `8/` y `9/` se disminuye varios órdenes de magnitud la covarianza del GPS, buscando que la trayectoria
estimada por MSF sea lo más similar posible a la del GPS (que estamos usando como ground-truth). Mediante esta prueba
se busca ver si mediante los parámetros de covarianza, efectivamente MSF obedece más a un sensor que a otro.
En `8/` se corrió ORB-SLAM3 sobre Euroc con parámetros 

* core/core_noise_acc: 0.016
* core/core_noise_accbias: 0.001
* core/core_noise_gyr: 0.000282
* core/core_noise_gyrbias: 0.0001
* pose_sensor/pose_noise_meas_p: 0.7
* pose_sensor/pose_noise_meas_q: 0.7
* position_pose_sensor/position_noise_meas: 0.0000001 

En `image.png` puede verse que MSF sigue al GPS.

En `9/` se realiza una prueba similar con R-VIO para la secuencia 02 del Rosario Dataset, con parámetros:
* core/core_noise_acc: 0.083
* core/core_noise_accbias: 0.0083
* core/core_noise_gyr: 0.0013
* core/core_noise_gyrbias: 0.00013
* pose_sensor/pose_noise_meas_p: 0.7
* pose_sensor/pose_noise_meas_q: 0.7
* position_pose_sensor/position_noise_meas: 0.0000001

En `image.png` pueden verse los resultados.
