import 'dart:io';
import 'dart:mirrors';
import 'package:dart_modules/common/controller.dart';
import 'package:dart_modules/common/module.dart';
import 'package:dart_modules/common/routes.dart';
import 'package:dart_modules/core/api_routes.dart';
import 'package:dart_modules/core/request_handler.dart';
import 'package:dart_modules/logger/logger.dart';

Logger logger = Logger();

class RoutesManager {
  static initailize(HttpRequest request, Type module) {
    ClassMirror classMirror = reflectClass(module);
    Iterable<InstanceMirror> metadata = classMirror.metadata;
    // Iterating through annotations
    for (InstanceMirror instanceMirror in metadata) {
      if (instanceMirror.reflectee is Module) {
        List<Type> controllers = [];

        List<Type> modules =
            instanceMirror.getField(Symbol('imports')).reflectee;

        if (modules.isNotEmpty) {
          for (var module in modules) {
            ClassMirror classMirror = reflectClass(module);
            Iterable<InstanceMirror> metadata = classMirror.metadata;
            for (InstanceMirror instanceMirror in metadata) {
              if (instanceMirror.reflectee is Module) {
                controllers.addAll(
                    instanceMirror.getField(Symbol('controllers')).reflectee);
              }
            }
          }
        }

        controllers
            .addAll(instanceMirror.getField(Symbol('controllers')).reflectee);

        if (controllers.isNotEmpty) {
          if (getRoutes.isEmpty &&
              postRoutes.isEmpty &&
              putRoutes.isEmpty &&
              patchRoutes.isEmpty &&
              deleteRoutes.isEmpty) {
            for (int i = 0; i < controllers.length; i++) {
              ClassMirror classMirror = reflectClass(controllers[i]);
              Iterable<InstanceMirror> metadata = classMirror.metadata;
              for (InstanceMirror instanceMirror in metadata) {
                if (instanceMirror.reflectee is Controller) {
                  extractingMethodFromClass(controllers[i]);
                } else {
                  logger.warning("Make sure you have passed Controller");
                }
              }
            }
            RequestHandler.handleRequest(request, module);
          } else {
            RequestHandler.handleRequest(request, module);
          }
        }
      } else {
        logger.warning("Make sure you have passed Module");
        return;
      }
    }
  }
}

void extractingMethodFromClass(Type classInstance) {
  // Get the mirror of the class
  ClassMirror classMirror = reflectClass(classInstance);
  // Create an instance of the class using reflection
  InstanceMirror instanceMirror = classMirror.newInstance(Symbol(''), []);
  // Iterate through the methods of the class
  classMirror.declarations.forEach((symbol, declaration) {
    // Check if the declaration is a MethodMirror
    if (declaration is MethodMirror) {
      declaration.metadata.forEach((meta) {
        //Delete Annotation
        if (meta.reflectee is Get) {
          Get getAnnot = meta.reflectee as Get;
          logger.info("GET: ${getAnnot.path}");
          getRoutes.addAll({
            getAnnot.path: () {
              return instanceMirror.invoke(symbol, []).reflectee;
            }
          });
        }
        //Post Annotation
        if (meta.reflectee is Post) {
          Post postAnnot = meta.reflectee as Post;
          logger.info("POST: ${postAnnot.path}");
          postRoutes.addAll({
            postAnnot.path: () {
              return instanceMirror.invoke(symbol, []).reflectee;
            }
          });
        }
        //Put Annotation
        if (meta.reflectee is Put) {
          Put putAnnot = meta.reflectee as Put;
          logger.info("PUT: ${putAnnot.path}");
          putRoutes.addAll({
            putAnnot.path: () {
              return instanceMirror.invoke(symbol, []).reflectee;
            }
          });
        }
        //Patch Annotation
        if (meta.reflectee is Patch) {
          Patch patchAnnot = meta.reflectee as Patch;
          logger.info("PATCH: ${patchAnnot.path}");
          patchRoutes.addAll({
            patchAnnot.path: () {
              return instanceMirror.invoke(symbol, []).reflectee;
            }
          });
        }
        //Delete Annotation
        if (meta.reflectee is Delete) {
          Delete deleteAnnot = meta.reflectee as Delete;
          logger.info("DELETE: ${deleteAnnot.path}");
          deleteRoutes.addAll({
            deleteAnnot.path: () {
              return instanceMirror.invoke(symbol, []).reflectee;
            }
          });
        }
      });
    }
  });
}
