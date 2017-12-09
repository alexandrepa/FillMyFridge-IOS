//
//  MySQLiteHelper.swift
//  FillMyFridge
//
//  Created by alexandre patelli on 08/12/2017.
//  Copyright © 2017 alexandre patelli. All rights reserved.
//

import Foundation
import SQLite

class MySQLiteHelper {
    var db : Connection!
    var pathString : String!
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        pathString = "\(path)/db.sqlite3"
    }
    func getPathString () -> String {
        return pathString
    }
    
    func connect() -> Connection {
        do {
            try db = try Connection(pathString)
            print(pathString)
        } catch {
            print(error)
        }
        return db
    }
    func createDatabases() {
        let DATABASE_CREATE_UTILISATEUR : String = "CREATE TABLE IF NOT EXISTS `Utilisateur` (\n" +
            "\t`ID`\tINTEGER PRIMARY KEY AUTOINCREMENT,\n" +
            "\t`Nom`\tTEXT\n" +
        ");"
        let DATABASE_CREATE_TAG : String = "CREATE TABLE IF NOT EXISTS `Tag` (\n" +
            "\t`ID`\tINTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                "\t`Label`\tTEXT NOT NULL\n" +
        ");"
        let DATABASE_CREATE_REPAS : String = "CREATE TABLE IF NOT EXISTS `Repas` (\n" +
            "\t`ID`\tINTEGER PRIMARY KEY AUTOINCREMENT,\n" +
            "\t`nom`\tTEXT,\n" +
            "\t`personnes`\tINTEGER NOT NULL,\n" +
            "\t`numero`\tINTEGER NOT NULL\n" +
        ");"
        let DATABASE_CREATE_PLAT : String = "CREATE TABLE IF NOT EXISTS `Plat` (\n" +
            "\t`ID`\tINTEGER PRIMARY KEY AUTOINCREMENT,\n" +
            "\t`intitule`\tTEXT NOT NULL\n" +
        ");"
        let DATABASE_CREATE_MENU : String = "CREATE TABLE IF NOT EXISTS `Menu` (\n" +
            "\t`ID`\tINTEGER PRIMARY KEY AUTOINCREMENT,\n" +
            "\t`nom`\tTEXT NOT NULL,\n" +
            "\t`date`\tINTEGER NOT NULL\n" +
        ");"
        let DATABASE_CREATE_LISTEMENUS : String = "CREATE TABLE IF NOT EXISTS `ListeMenus` (\n" +
            "\t`ID`\tINTEGER PRIMARY KEY AUTOINCREMENT,\n" +
            "\t`date_debut`\tINTEGER NOT NULL,\n" +
            "\t`date_fin`\tINTEGER NOT NULL\n" +
        ");"
        let DATABASE_CREATE_INGREDIENT : String = "CREATE TABLE IF NOT EXISTS `Ingredient` (\n" +
            "\t`Nom`\tTEXT NOT NULL,\n" +
            "\t`ID`\tINTEGER PRIMARY KEY AUTOINCREMENT\n" +
        ");"
        let DATABASE_CREATE_UTILISATEUR_LISTEMENUS : String = "CREATE TABLE IF NOT EXISTS `Utilisateur_ListeMenus` (\n" +
            "\t`Utilisateur`\tINTEGER,\n" +
            "\t`ListeMenus`\tINTEGER,\n" +
            "\tFOREIGN KEY(`Utilisateur`) REFERENCES `Utilisateur`,\n" +
            "\tPRIMARY KEY(`Utilisateur`,`ListeMenus`),\n" +
            "\tFOREIGN KEY(`ListeMenus`) REFERENCES `ListeMenus`\n" +
        ");"
        let DATABASE_CREATE_REPAS_PLAT : String = "CREATE TABLE IF NOT EXISTS `Repas_Plat` (\n" +
            "\t`repas`\tINTEGER,\n" +
            "\t`plat`\tINTEGER,\n" +
            "\tFOREIGN KEY(`plat`) REFERENCES `Plat`,\n" +
            "\tPRIMARY KEY(`plat`,`repas`),\n" +
            "\tFOREIGN KEY(`repas`) REFERENCES `Repas`\n" +
        ");"
        let DATABASE_CREATE_PLAT_TAG : String = "CREATE TABLE IF NOT EXISTS `Plat_Tag` (\n" +
            "\t`plat`\tINTEGER,\n" +
            "\t`tag`\tINTEGER,\n" +
            "\tFOREIGN KEY(`tag`) REFERENCES `Tag`,\n" +
            "\tFOREIGN KEY(`plat`) REFERENCES `Plat`,\n" +
            "\tPRIMARY KEY(`tag`,`plat`)\n" +
        ");"
        let DATABASE_PLAT_INGREDIENT  : String = "CREATE TABLE IF NOT EXISTS `Plat_Ingredient` (\n" +
            "\t`plat`\tINTEGER,\n" +
            "\t`ingredient`\tINTEGER,\n" +
            "\t`grammes`\tINTEGER,\n" +
            "\tPRIMARY KEY(`plat`,`ingredient`),\n" +
            "\tFOREIGN KEY(`ingredient`) REFERENCES `Ingredient`,\n" +
            "\tFOREIGN KEY(`plat`) REFERENCES `Plat`\n" +
        ");"
        let DATABASE_MENU_REPAS : String = "CREATE TABLE IF NOT EXISTS `Menu_Repas` (\n" +
            "\t`menu`\tINTEGER,\n" +
            "\t`repas`\tINTEGER,\n" +
            "\tFOREIGN KEY(`repas`) REFERENCES `Repas`,\n" +
            "\tPRIMARY KEY(`repas`,`menu`),\n" +
            "\tFOREIGN KEY(`menu`) REFERENCES `Menu`\n" +
        ");"
        let DATABASE_CREATE_LISTEMENUS_MENU : String = "CREATE TABLE IF NOT EXISTS `ListeMenus_Menu` (\n" +
            "\t`listemenus`\tINTEGER,\n" +
            "\t`menu`\tINTEGER,\n" +
            "\tPRIMARY KEY(`listemenus`,`menu`),\n" +
            "\tFOREIGN KEY(`listemenus`) REFERENCES `ListeMenus`,\n" +
            "\tFOREIGN KEY(`menu`) REFERENCES `Menu`\n" +
        ");"
        
        do {
            try db.execute(DATABASE_CREATE_UTILISATEUR)
            try db.execute(DATABASE_CREATE_TAG)
            try db.execute(DATABASE_CREATE_REPAS)
            try db.execute(DATABASE_CREATE_PLAT)
            try db.execute(DATABASE_CREATE_MENU)
            try db.execute(DATABASE_CREATE_LISTEMENUS)
            try db.execute(DATABASE_CREATE_INGREDIENT)
            try db.execute(DATABASE_CREATE_UTILISATEUR_LISTEMENUS)
            try db.execute(DATABASE_CREATE_REPAS_PLAT)
            try db.execute(DATABASE_CREATE_PLAT_TAG)
            try db.execute(DATABASE_PLAT_INGREDIENT)
            try db.execute(DATABASE_MENU_REPAS)
            try db.execute(DATABASE_CREATE_LISTEMENUS_MENU)
        } catch {
            print(error)
        }
        self.initTags()
        self.initPlat()
        self.initIngredients()
        self.initPlatsTags()
        self.initPlatsIngredients()
        
        
    }
    func initIngredients(){
        do {
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Lardons',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Une pâte brisée',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Crème fraîche',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Farine',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Lait',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Oeuf',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Gruyère râpé',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Poivre',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Sel',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Muscade',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Foie de veau',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Raisin sec',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Porto',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Vin Blanc',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Beurre',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Echalotes',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Blanc de poulet',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Oignon jaune',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Curry',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Cumin',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Piment',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Morceaux de dinde',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Huile d olive',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Oignon blanc',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Bouillon de volaille',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Concentré de tomate',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Tomates',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Ail',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Herbe de provence',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Pâte à lasagnes',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Viande hachée de boeuf',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Saucisse',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Carotte',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Céleri',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Basilic',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Mozzarella',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Béchamel',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Aubergine',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Courgette',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Poivron',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Thym',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Laurier',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Riz rond',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Champignons',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Mascarpone',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Parmesan',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Melon',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Avocat',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Olive Noire',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Tomate cerise',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Sésame',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Citron vert',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Fines herbes',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Coeur de laitue',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Croûtons',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Capres',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Moutarde',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Tabasco',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Citron jaune',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Salade',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Sorbet au citron vert',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Vinaigre balsamique',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Comcombre',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Olive verte',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Bûche de chèvre',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Pomme de terre',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Paprika',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Coriandre moulue',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Purée de pomme de terre',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Herbe de provence',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Jaune d oeuf',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Blanc d oeur',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Fromage rapé',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Jambon',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Haricots verts',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Quinoa',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Menthe',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Cuisse de poulet',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Epice à tajine',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Tomate séchée',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Ras el Hanout',NULL);")
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Cannelle',NULL);")
            
            try db.execute("INSERT INTO `Ingredient`(`Nom`,`ID`) VALUES ('Spaghetti',NULL);")
        } catch {
            print(error)
        }
        }
    func initPlat(){
        do {
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Quiche Lardon Gruyère');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Foie de veau au Porto et au raisins secs');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Poulet au curry et aux oignons');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Osso Bucco de dinde');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Lasagnes');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Ratatouille');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Risotto aux champignons');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Salade melon mozzarella & avocat');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Salade cesar');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Salade d avocat au citron vert');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Salade de comcombre au chèvre et olives');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Salade de pomme de terre épicée');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Hachis parmentier');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Gratin d auphinois');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Gratin de courgettes');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Roulé de jambon aux haricots verts');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Salade de quinoa');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Tajine de poulet');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Tajine de légumes');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Spaghetti carbonara');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Carottes à la carbonara');")
            try db.execute("INSERT INTO `Plat`(`ID`,`intitule`) VALUES (NULL,'Pâtes bolognaise');")
        } catch {
            print(error)
        }
    }
    func initTags(){
        do {
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Gourmand');")
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Elaboré');")
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Végétarien');")
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Salades');")
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Familial');")
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Gratin');")
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Healthy');")
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Exotique');")
            try db.execute("INSERT INTO `Tag`(`ID`,`Label`) VALUES (NULL,'Variante');")
        } catch {
            print(error)
        }
    }
    func initPlatsTags(){
        do {
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (1,1);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (2,2);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (3,1);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (4,2);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (5,5);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (6,3);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (7,2);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (8,3);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (9,4);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (10,4);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (11,4);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (12,4);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (13,5);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (14,6);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (15,6);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (16,7);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (17,4);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (18,8);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (19,8);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (20,1);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (21,9);")
            try db.execute("INSERT INTO `Plat_Tag`(`plat`,`tag`) VALUES (22,1);")
        } catch {
            print(error)
        }
    }
    func initPlatsIngredients(){
        do {
            //QUICHE LARDON GRUYERE
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,1,25);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,2,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,3,8);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,4,8);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,5,40);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,6,58);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,7,25);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,9,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (1,10,-1);")
            
            //FOIE DE VEAU
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,11,150);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,12,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,13,21);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,14,36);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,15,13);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,16,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,4,4);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (2,9,-1);")
            
            //POULET CURRY
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (3,17,110);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (3,18,70);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (3,3,250);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (3,19,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (3,20,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (3,21,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (3,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (3,9,-1);")
            
            //OSSO BUCCO DE DINDE
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,22,110);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,4,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,23,8);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,24,35);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,14,2);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,25,2);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,26,38);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,27,84);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,28,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,9,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (4,29,-1);")
            
            //LASAGNES
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,30,100);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,31,63);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,32,38);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,26,38);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,27,38);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,24,10);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,33,15);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,34,15);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,23,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,9,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,35,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (5,36,60);")
            
            //RATATOUILLE
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,38,88);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,39,88);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,40,88);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,24,88);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,27,130);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,28,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,23,22);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,41,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,42,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (6,9,-1);")
            
            //RISOTTO
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,43,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,44,75);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,3,125);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,45,15);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,24,35);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,28,10);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,9,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (7,46,38);")
            
            //MELON AVOCAT
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,47,300);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,48,150);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,36,40);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,49,15);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,50,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,51,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,52,20);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,23,23);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,9,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (8,53,-1);")
            
            //SALADE CESAR
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,54,150);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,46,13);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,55,12);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,23,58);")
            //try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,46,3);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,56,3);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,57,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,58,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,59,120);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,28,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (9,9,-1);")
            
            //SALADE AVOCAT CITRON VERT
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (10,48,90);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (10,60,40);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (10,61,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (10,23,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (10,62,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (10,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (10,9,-1);")
            
            //SALADE DE COMCOMBRE AU CHEVRE ET OLIVE
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (11,63,150);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (11,64,35);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (11,65,70);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (11,23,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (11,62,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (11,35,-1);")
            
            //SALADE DE POMME DE TERRE EPICEE
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,66,130);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,23,7);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,59,60);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,51,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,67,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,68,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,20,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (12,9,-1);")
            
            //HACHIS PARMENTIER
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,31,100);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,69,75);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,24,65);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,28,40);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,27,60);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,4,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,71,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,46,8);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,15,8);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,7,13);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (13,9,-1);")
            
            //GRATIN D'AUPHINOIS
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (14,66,500);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (14,28,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (14,3,20);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (14,15,17);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (14,5,500);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (14,10,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (14,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (14,9,-1);")
            
            //GRATIN DE COURGETTES
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (15,39,120);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (15,24,70);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (15,7,25);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (15,6,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (15,3,8);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (15,15,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (15,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (15,9,-1);")
            
            //ROULE JAMBON HARICOT
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (16,74,70);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (16,75,40);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (16,27,10);")
            
            //SALADE DE QUINOA
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,76,110);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,63,60);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,27,27);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,77,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,16,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,28,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,23,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,59,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (17,8,-1);")
            
            //TAJINE DE POULET
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,78,110);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,39,70);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,66,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,33,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,27,60);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,24,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,79,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,20,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (18,23,15);")
            
            //TAJINE DE LEGUME
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,39,80);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,33,60);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,40,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,24,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,80,70);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,26,60);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,23,15);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,9,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,81,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (19,82,-1);")
            
            //SPAGHETTI CARBONARA
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (20,83,130);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (20,1,150);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (20,46,30);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (20,3,35);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (20,71,30);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (20,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (20,9,-1);")
            
            //CAROTTES CARBONARA
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (21,33,130);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (21,71,30);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (21,24,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (21,3,55);")
            //try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (21,33,90);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (21,1,50);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (21,9,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (21,8,-1);")
            
            //PATE BOLOGNAISE
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,83,75);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,31,110);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,26,70);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,24,65);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,28,40);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,58,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,46,25);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,23,8);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,8,-1);")
            try db.execute("INSERT INTO `Plat_Ingredient`(`plat`,`ingredient`,`grammes`) VALUES (22,9,-1);")
        } catch {
            print(error)
        }
    }
    
    
}
