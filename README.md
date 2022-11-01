___
# Smart Planting System
___


## Team
-  E/18/154, Jayasumana C.H. [email](mailto:e18154@eng.pdn.ac.lk)
-  E/18/349, Thalisha W.G.A.P. [email](mailto:e18349@eng.pdn.ac.lk)
-  E/18/327, Senevirathna M.D.C.D. [email](mailto:e18327@eng.pdn.ac.lk)


#### Table of Contents
1. [Introduction](#introduction)
2. [Solution Architecture](#solution-architecture )
3. [Hardware & Software Designs](#hardware-and-software-designs)
4. [Testing](#testing)
5. [Detailed budget](#detailed-budget)
6. [Conclusion](#conclusion)
7. [Links](#links)


## Introduction

Taking care of plants can be largely time consuming. Missing even a small scheduled task to the plant can result in drying up of the plant or even its death. Watering the plant, checking the amount of moisture in the soil are another very important and time consuming tasks. Another big problem in the houses(apartments) is the space.

But with the busy lifestyle people have less time and they don’t tend to plant trees and take care of them. As a solution to this problem, we are producing this smart pot to promote the concept, “plants as pets”. And this smart pot is also ideal for gardeners who are interested in planting plants like Bonsai where special conditions are needed.


## Solution Architecture

<p align="center" > <img src="docs/images/Solution_Architecture.png" style="width:600px;"> </p>

## Hardware and Software Designs

Detailed designs with many sub-sections

## Testing

Testing done on hardware and software, detailed + summarized results

## Detailed budget

All items and costs

| Item          | Quantity  | Unit Cost (LKR)  | Total (LKR)  |
| ------------- |:---------:|:----------:|-------:|
| Arduino Uno board   | 1         | 10.00    | 50.00 |
| Water level sensor depth detection| 1 | 120.00 | 120.00|
| Capacitive soil moisture sensor | 1 | 400.00 | 400.00|
|LDR light sensor| 1 | 200.00 | 200.00 |
|1.8 - inch 128x160 SPI TFT LCD Display mode | 1 | 1800.00 | 1800.00|
| Serial WIFI Wireless Module | 1 | 550.00 | 550.00 |
| DS18B20 Digital Temperature Sensor Probe | 1 | 400.00 | 400.00 |
| Water Pump | 1 | 450.00 | 450.00|
| OV7670 Camera Module for Arduino | 1 | 960.00 | 960.00 |
|12V 2500mAh Rechargeable Lipo Battery | 1 | 3300.00 | 3300.00|
| Wires and other | | | 1000.00|
| Total |||12980.00|


## Conclusion

What was achieved, future developments, commercialization plans

## Links

- [Project Repository](https://github.com/cepdnaclk/e18-3yp-Smart-Plant-Pot)
- [Project Page](https://cepdnaclk.github.io/e18-3yp-Smart-Planting-System)
- [Department of Computer Engineering](http://www.ce.pdn.ac.lk/)
- [University of Peradeniya](https://eng.pdn.ac.lk/)

___

# eYY-3yp-project-template

This is a sample repository you can use for your Embedded Systems project. Once you followed these instructions, remove the text and add a brief introduction to here.

### Enable GitHub Pages

You can put the things to be shown in GitHub pages into the _docs/_ folder. Both html and md file formats are supported. You need to go to settings and enable GitHub pages and select _main_ branch and _docs_ folder from the dropdowns, as shown in the below image.

![image](https://user-images.githubusercontent.com/11540782/98789936-028d3600-2429-11eb-84be-aaba665fdc75.png)

### Special Configurations

These projects will be automatically added into [https://projects.ce.pdn.ac.lk](). If you like to show more details about your project on this site, you can fill the parameters in the file, _/docs/index.json_

```
{
  "title": "This is the title of the project",
  "team": [
    {
      "name": "Chamudi Jayasumana",
      "email": "e18349@eng.pdn.ac.lk",
      "eNumber": "E/18/349"
    },
    {
      "name": "Anushanga Pavith",
      "email": "e18349@eng.pdn.ac.lk",
      "eNumber": "E/18/349"
    },
    {
      "name": "Chamara Dilshan",
      "email": "e18327@eng.pdn.ac.lk",
      "eNumber": "E/18/327"
    }
  ],
  "supervisors": [
    {
      "name": "Dr. Isuru Nawinne",
      "email": "isurunawinne@eng.pdn.ac.lk"
    },
    {
      "name": "Dr. Mahanama Wickramasinghe",
      "email": "mahanamaw@eng.pdn.ac.lk"
    }
  ],
  "tags": ["Web", "Embedded Systems", "Mobile app", "Plants"]
}
```

Once you filled this _index.json_ file, please verify the syntax is correct. (You can use [this](https://jsonlint.com/) tool).

### Page Theme

A custom theme integrated with this GitHub Page, which is based on [github.com/cepdnaclk/eYY-project-theme](https://github.com/cepdnaclk/eYY-project-theme). If you like to remove this default theme, you can remove the file, _docs/\_config.yml_ and use HTML based website.
