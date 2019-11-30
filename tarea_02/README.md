# Procesamiento Adaptativo - Tarea 2

El siguiente folder del repositorio del curso contiene los resultados asociados a la implementación de 
diez algoritmos iterativos distintos para resolver el problema de optimatización de mínimos cuadrados 
(en inglés, LMS). Cada uno de estos algoritmos es utilizado para estimar los coeficientes de un canal 
de respuesta finita (en inglés, FIR channel), a partir de una secuencia de observaciones aleatorias 
relativas a dicho canal y muestras resultantes del mismo. Aquí, en este archivo, se analiza cuál de 
los métodos iterativos genera una mejor aproximación del vector relativo a este canal y adicionalmente, 
se establecen valores exactos de los coeficientes del canal FIR, asumiendo que estos son números enteros.


## Pregunta 1
Cada uno de estos algoritmos de gradiente estocásticos se encuentran desarrollados en los scripts de 
Matlab/Octave en la carpeta [src](src/) de este repositorio, los cuales constituyen diversas propuesta 
para la resolución del problema de mínimos cuadrados. Seguidamente, estos serán empleados para la estimación 
de un canal FIR, tomando en cuenta condiciones de parada de ejecución relativas a una tolerancia y un 
número máximo de iteraciones que son definidas en los archivos de prueba, descritos en la próxima sección 
del documento.

## Pregunta 2
En el folder denotado como [test](test/) se encuentra los scripts que ejecutan los diez algoritmos 
implementados en el primer ejercicio a manera de banco de pruebas donde se despliegan las métricas 
más relevantes de estas métodos de minización de cuadrados, así como las gráficas que describen el 
comportamiento de dichas métricas con respecto al número de iteraciones.


### Inciso a
Esta sección del documento muestra los coeficientes del canal de respuesta finita denominado C, 
calculados de forma aproximada, mediante la implementación de los diez algoritmos de gradiente 
estocásticos dados en la referencia, junto el valor de las constantes utilizadas para la ejecución 
del algoritmo, así como las condiciones de parada respectivas.

Cabe destacar que para el caso de las pruebas de los algoritmos **Least-mean-fourth (LMF)** y 
**Least-mean-mixed-norm (LMMN)** fue necesario ajustar el orden magnitud de la tolerancia dada, 
mediante la reducción en un factor de 4 y 2, respectivamente, tal y como se muestra a continuación, 
con el propósito de obtener los valores esperados, así como métricas válidas para evaluar estas 
implementaciones.

#### LMS con paso constante
```
Simulation start
...
  tol    = 1e-05
iter_max = 100000
   mu    = 0.005
...
c_vector =

   9.842731
   3.058489
   7.940234
  -7.828063
   2.953181
   0.020399
   5.890393
  -4.933703
  -5.945699
  -8.794210

Simulation end
```

#### LMS con paso variable en el tiempo
```
Simulation start
...
  tol    = 1e-05
iter_max = 100000
...
c_vector =

   10.087196
    2.978698
    7.974975
   -7.941294
    3.104635
   -0.017278
    6.031067
   -5.000984
   -6.025387
   -9.082537

Simulation end
```

#### LMS e-normalizado
```
Simulation start
...
  tol    = 1e-05
iter_max = 100000
   mu    = 0.05
 epsilon = 1e-06
...
c_vector =

   9.842731
   3.058489
   7.940234
  -7.828063
   2.953181
   0.020399
   5.890393
  -4.933703
  -5.945699
  -8.794210

Simulation end
```

#### e-NLMS con potencia normalizada
```
Simulation start
...
  tol    = 1e-05
iter_max = 100000
   mu    = 0.025
 epsilon = 5e-07
  beta   = 0.8
...
c_vector =

   9.6646271
   2.9269117
   7.7852077
  -7.7502263
   2.8299363
   0.0018962
   5.8033265
  -4.8072292
  -5.8650496
  -8.6138140

Simulation end
```

#### LMS error-signo
```
Simulation start
...
  tol    = 1e-05
iter_max = 100000
   mu    = 0.0125
...
c_vector =

   9.950000
   2.875000
   7.950000
  -8.050000
   3.000000
  -0.025000
   6.075000
  -4.950000
  -5.975000
  -9.150000

Simulation end
```

#### *leaky-LMS*
```
Simulation start
...
  tol    = 1e-05
iter_max = 100000
   mu    = 0.001
 alpha   = 0.01
...
c_vector =

   9.900051
   2.984880
   7.908014
  -7.915617
   2.977630
   0.013093
   5.944019
  -4.962518
  -5.943851
  -8.924026

Simulation end
```

#### *Least-mean-fourth (LMF)*
```
Simulation start
...
  tol    = 1e-20
iter_max = 100000
   mu    = 1.5e-05
...
c_vector =

   9.7649e+00
   2.9908e+00
   7.9509e+00
  -7.9276e+00
   2.9996e+00
   5.5408e-04
   5.9642e+00
  -4.9686e+00
  -5.9453e+00
  -8.9119e+00

Simulation end
```

#### *Least-mean-mixed-norm (LMMN)*
```
Simulation start
...
  tol    = 1e-10
iter_max = 100000
   mu    = 1.5e-05
  delta  = 0.5
...
c_vector =

   9.8334583
   2.9882825
   7.9438674
  -7.9228272
   2.9881092
   0.0059406
   5.9564582
  -4.9610196
  -5.9543469
  -8.8964289

Simulation end
```

#### RLS
```
Simulation start
...
  tol    = 1e-05
iter_max = 100000
 epsilon = 1e-15
  lambda = 1
...
c_vector =

   9.95921
   2.92642
   7.98709
  -8.12979
   3.00050
  -0.14768
   5.98013
  -5.11184
  -6.00901
  -9.01670

Simulation end
```

#### Gauss-Newton (GN)
```
Simulation start
...
  tol    = 1e-05
iter_max = 100000
  alpha  = 0.01
 epsilon = 2.5e-17
  lambda = 0.989
   mu    = 0.025
...
c_vector =

   9.998439
   2.965811
   7.991158
  -8.030767
   3.065815
  -0.026746
   6.006392
  -5.045482
  -5.990762
  -9.026377

Simulation end
```


### Inciso b
La siguiente tabla resume los valores obtenidos de las principales métricas para cada uno de los 
algoritmos, sumado con las [gráficas](results/plots/) que evidencian tales resultados, los cuales
permiten determinar que el método iterativo que genera una mejor aproximación del canal FIR
corresponde al algoritmo **LMS error-signo**, puesto que el valor del k-ésimo error equivale a 0 
y el valor mínimo computado es prácticamente 0 con un orden de magnitud de -14, a costa de unas 
5533 iteraciones.

De la misma forma, el **Least-mean-fourth (LMF)** produce valores muy pequeños, pero luego de unas 
75 mil iteraciones, siendo computacionalmente más costoso. Adicionalmente, cabe destacar que la 
implementación del **RLS** presenta un buen rendimiento computacional ya que requiere de aproxidamente 
400 iteraciones, para realizar una estimación aceptable del vector C, con un k-ésimo error y un valor 
mínimo cuyos órdenes de magnitud equivalen a -6 y -7 respetivamente.

##### Tabla 2.2.  Medidas asociadas a los algoritmos de gradiente estocástico.

| Algoritmo                          |   k-iter   |     k-error     |    val min    |
| ---------------------------------- | ---------- | --------------- | ------------- |
| LMS con paso constante             |     813    |   8.60515e-06   |  2.96194e-07  |
| LMS con paso variable en el tiempo |     857    |   9.44600e-06   |  1.64214e-06  |
| LMS e-normalizado                  |     813    |   8.60041e-06   |  2.95869e-07  |
| e-NLMS con potencia normalizada    |    1302    |   2.83926e-06   |  1.28982e-07  |
| LMS error-signo                    |    5533    |   0.00000e-00   | -5.68434e-14  |
| *leaky-LMS*                        |  100000    |   0.000414683   |  0.00862183   |
| *Least-mean-fourth (LMF)*          |   74993    |   0.00000e-00   |  1.47082e-11  |
| *Least-mean-mixed-norm (LMMN)*     |  100000    |   4.83083e-07   |  0.000414535  |
| RLS                                |     407    |   7.07043e-06   |  9.02289e-07  |
| Gauss-Newton (GN)                  |     422    |   2.64570e-06   |  1.23998e-08  |


### Inciso c
El valor exacto del vector C conociendo que los coeficientes del canal FIR son números enteros, 
equivale a:
```
     _        _
    |    10    |
    |     3    |
    |     8    |
    |    -8    |
C = |     3    |
    |     0    |
    |     6    |
    |    -5    |
    |    -6    |
    |_   -9   _|

```

Debido a que, como fue posible observar en el inciso anterior, estos valores del vector C son 
números racionales, donde efecutando una aproximación entera (*Nota: aprox. de 32 bits a nivel 
de Matlab/Octave*) a dicho vector, es posible notar por simple inspeción que los valores son 
iguales para los diez algoritmos implementados en el Ejercicio 1, deduciendo así un valor 
exacto para el vector C.


## Referencias
* *Sayed, A. H. (2003). Fundamentals of adaptive filtering. John Wiley & Sons.*
