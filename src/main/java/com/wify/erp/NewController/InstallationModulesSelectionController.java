package com.wify.erp.NewController;

import com.wify.erp.NewPojo.*;
import com.wify.erp.repository.*;
import com.wify.erp.services.MethodsCalledService;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.ListIterator;

@Controller
public class InstallationModulesSelectionController {

    @Autowired
    public MethodsCalledService methodsCalledService;

    @Autowired
    private InventoryProductsRepository inventoryProductsRepository;

    @Autowired
    private QuotationBOMRepository quotationBOMRepository;

    @Autowired
    private QuotationRepository quotationRepository;

    @Autowired
    private RoomBoardsRepository roomBoardsRepository;

    @Autowired
    private LeadsRepository leadsRepository;

    @Autowired
    private ClientRepository clientRepository;

    @Autowired
    private SalesPartnerRepository salesPartnerRepository;

    @RequestMapping("/viewBoardsData/{quotationID}")
    public String viewBoardsData(HttpServletRequest request, ModelMap map, @PathVariable String quotationID) {

        try {

            Quotation quotation = quotationRepository.findById(quotationID);

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level", salesPartner.getLevel());

            map.addAttribute("quotationNum", quotation.getqNum());

            map.addAttribute("quotationID", quotationID);

            map.addAttribute("clientID", quotation.getClientId());

            if (leadsRepository.existsById(quotation.getClientId())) {

                map.addAttribute("clientType", "lead");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("lead", quotation.getClientId()));

            } else if (clientRepository.existsById(quotation.getClientId())) {

                map.addAttribute("clientType", "client");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("client", quotation.getClientId()));

            }

            map.addAttribute("boardsData", roomBoardsRepository.findAllByQuotationID(quotationID));

            map.addAttribute("roomBoardSize", roomBoardsRepository.findAllByQuotationID(quotationID).size());

            map.addAttribute("quotationBOMSize", quotationBOMRepository.findAllByQuotationID(quotationID).size());

        } catch (Exception e) {

            e.printStackTrace();
        }
        return "boardsData";
    }

    @RequestMapping("/installationModulesSelection/{type}/{key}/{quotationID}")
    public String installationModulesSelection(HttpServletRequest request, ModelMap map, @PathVariable String type, @PathVariable String key, @PathVariable String quotationID) {

        try {

            SalesPartner salesPartner = salesPartnerRepository.findByEmail(LoginController.getCookieEmail(request));

            map.addAttribute("level", salesPartner.getLevel());

            Quotation quotation = quotationRepository.findById(quotationID);

            map.addAttribute("roomName", quotation.getRoomName());

            map.addAttribute("quotationNum", quotation.getqNum());

            map.addAttribute("quotationID", quotationID);

            map.addAttribute("clientID", quotation.getClientId());

            if (leadsRepository.existsById(quotation.getClientId())) {

                map.addAttribute("clientType", "lead");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("lead", quotation.getClientId()));

            } else if (clientRepository.existsById(quotation.getClientId())) {

                map.addAttribute("clientType", "client");

                map.addAttribute("clientName", methodsCalledService.fetchClientName("client", quotation.getClientId()));

            }

            if (type.equalsIgnoreCase("add")) {

                map.addAttribute("boardsCount", quotation.getBoardCount());

//                map.addAttribute("roomName", quotation.getRoomName());

//                map.addAttribute("quotationID", quotationID);

                map.addAttribute("type", type);

                map.addAttribute("roomBoardsObj", new RoomBoards());
            }

            if (type.equalsIgnoreCase("edit")) {

                map.addAttribute("boardsCount", 1);

//                map.addAttribute("roomName", quotation.getRoomName());

//                map.addAttribute("quotationID", quotationID);

                map.addAttribute("type", type);

                map.addAttribute("roomBoardsObj", roomBoardsRepository.findById(key));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }
        return "installationModulesSelection";
    }

    @RequestMapping("/addInstallationModulesSelectionForm/{quotationID}")
    public String addInstallationModulesSelectionForm
            (@RequestParam MultiValueMap<String, String> parameters, @PathVariable String quotationID) {

        int GCount = Integer.parseInt(parameters.get("lightPoint").get(0));

        int fanCount = Integer.parseInt(parameters.get("fan").get(0));

        int RGBCount = Integer.parseInt(parameters.get("rgb").get(0));

        int PCount = Integer.parseInt(parameters.get("power").get(0));

        Quotation quotation = new Quotation();

        try {

            quotation = quotationRepository.findById(quotationID);

            String boardName = "Board";

            int c = roomBoardsRepository.findByQuotationIDAndRoomName(quotationID, quotation.getRoomName()).size();

            c++;

            boardName = boardName + " " + c;

            String id = new ObjectId().toString();

            RoomBoards roomBoards = new RoomBoards();

            roomBoards.setId(id);

            roomBoards.setRoomName(quotation.getRoomName());

            roomBoards.setBoardName(boardName);

            roomBoards.setQuotationID(quotationID);

            roomBoards.setLightPoint(GCount);

            roomBoards.setRgb(RGBCount);

            roomBoards.setFan(fanCount);

            roomBoards.setPower(PCount);

            roomBoardsRepository.save(roomBoards);

//            quotation.setBoardCount(quotation.getBoardCount() - 1);

            if (quotation.getBoardCount() == 0) {

//                quotation.setRoomName("");
            }

            quotationRepository.save(quotation);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/viewBoardsData/" + quotationID;
    }

    @RequestMapping("/updateInstallationModulesSelectionForm/{updateKey}/{quotationId}")
    public String updateInstallationModulesSelectionForm(@RequestParam MultiValueMap<String, String> parameters, @PathVariable String updateKey, @PathVariable String quotationId) {

        try {

            RoomBoards roomBoards = roomBoardsRepository.findById(updateKey);

            roomBoards.setLightPoint(Integer.parseInt(parameters.get("lightPoint").get(0)));

            roomBoards.setFan(Integer.parseInt(parameters.get("fan").get(0)));

            roomBoards.setRgb(Integer.parseInt(parameters.get("rgb").get(0)));

            roomBoards.setPower(Integer.parseInt(parameters.get("power").get(0)));

            roomBoardsRepository.save(roomBoards);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/viewBoardsData/" + quotationId;
    }

    @RequestMapping("/saveBoardsCountData/{quotationID}")
    public String saveBoardsCountData
            (@RequestParam MultiValueMap<String, String> parameters, @PathVariable String quotationID) {

        try {

            Quotation q1 = quotationRepository.findById(quotationID);

            q1.setRoomName(parameters.get("roomName").get(0));

            q1.setBoardCount(Integer.parseInt(parameters.get("boardCount").get(0)));

            quotationRepository.save(q1);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/installationModulesSelection/" + "add" + "/" + "null" + "/" + quotationID;
    }

    public String saveModuleDataInDatabase(String moduleType, int count, String quotationID, String roomName) {

        Inventory_Products products = new Inventory_Products();

        int totalPrice = 0;

        try {

            methodsCalledService.addMiniserverByDefault(quotationID);

            products = inventoryProductsRepository.findByNameContains(moduleType);

            if (quotationBOMRepository.existsByQuotationIDAndPname(quotationID, products.getName())) {

                QuotationBOM bom = quotationBOMRepository.findByQuotationIDAndPname(quotationID, products.getName());

                String finalQuantity = Integer.toString(Integer.parseInt(bom.getQuantity()) + count);

                bom.setQuantity(finalQuantity);

                bom.setRoomName(roomName);

                quotationBOMRepository.save(bom);

            } else {

                totalPrice = totalPrice + Integer.parseInt(products.getPrice()) * count;

                QuotationBOM quotationBOM = new QuotationBOM();

                quotationBOM.setId(new ObjectId().toString());

                quotationBOM.setQuantity(Integer.toString(count));

                quotationBOM.setQuotationID(quotationID);

                quotationBOM.setPackageName("");

                quotationBOM.setPcode(products.getProductCode());

                quotationBOM.setPname(products.getName());

                quotationBOM.setPrice(products.getPrice());

                quotationBOM.setRoomName(roomName);

                quotationBOMRepository.save(quotationBOM);

            }
        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    public String saveControllerDataInDatabase(ControllerPojo controllerPojo, String quotationID, String roomName) {

        int size = 0;

        try {

            methodsCalledService.addMiniserverByDefault(quotationID);

            Inventory_Products products = new Inventory_Products();

            int totalPrice = 0;

            if (controllerPojo.getPower() > 0) {

                products = inventoryProductsRepository.findByNameContains("Power");

                totalPrice = totalPrice + Integer.parseInt(products.getPrice()) * controllerPojo.getPower();

            }

            if (controllerPojo.getGeneric() > 0) {

                products = inventoryProductsRepository.findByNameContains("Generic");

                totalPrice = totalPrice + (Integer.parseInt(products.getPrice()) / 3) * controllerPojo.getGeneric();

            }

            products = inventoryProductsRepository.findByNameContains("Controller");

            size = quotationBOMRepository.findAllByQuotationIDAndPnameContains(quotationID, "Controller").size();

            size++;

            String id = new ObjectId().toString();

            controllerPojo.setId(id);

            controllerPojo.setQuantity("1");

            controllerPojo.setQuotationID(quotationID);

            controllerPojo.setPackageName("");

            controllerPojo.setPcode(products.getProductCode());

            controllerPojo.setPname(products.getName() + " " + size);

            controllerPojo.setPrice(Integer.toString(totalPrice));

            controllerPojo.setRoomName(roomName);

            quotationBOMRepository.save(controllerPojo);

            List<Object> list = quotationBOMRepository.findAllByQuotationIDAndRoomNameAndPnameContains(quotationID, roomName, "Controller");

            ListIterator iterator = list.listIterator();

            while (iterator.hasNext()) {

                ControllerPojo bom = (ControllerPojo) iterator.next();

                if (bom.getGeneric() < 4 && bom.getGeneric() > 0 && bom.getPower() == 0 && quotationBOMRepository.findAllByQuotationIDAndRoomName(bom.getQuotationID(), bom.getRoomName()).size() > 1) {

                    products = inventoryProductsRepository.findByNameContains("Generic");

                    bom.setPname(products.getName());

                    bom.setPcode(products.getProductCode());

                    if (quotationBOMRepository.existsByQuotationIDAndPname(quotationID, products.getName())) {

                        QuotationBOM bom1 = quotationBOMRepository.findByQuotationIDAndPname(quotationID, products.getName());

                        String finalQuantity = Integer.toString(Integer.parseInt(bom1.getQuantity()) + Integer.parseInt(bom.getQuantity()));

                        bom1.setQuantity(finalQuantity);

                        quotationBOMRepository.deleteById(bom.getId());

                        quotationBOMRepository.save(bom1);

                    } else {

                        quotationBOMRepository.save(bom);
                    }

                    size = quotationBOMRepository.findAllByQuotationIDAndPnameContains(quotationID, "Controller").size();

                    controllerPojo.setPname("Controller Module " + size);

                    quotationBOMRepository.save(controllerPojo);

                } else if (bom.getPower() == 1 && bom.getGeneric() == 0 && quotationBOMRepository.findAllByQuotationIDAndRoomName(bom.getQuotationID(), bom.getRoomName()).size() > 1) {

                    products = inventoryProductsRepository.findByNameContains("Power");

                    bom.setPname(products.getName());

                    bom.setPcode(products.getProductCode());

                    if (quotationBOMRepository.existsByQuotationIDAndPname(quotationID, products.getName())) {

                        QuotationBOM bom1 = quotationBOMRepository.findByQuotationIDAndPname(quotationID, products.getName());

                        String finalQuantity = Integer.toString(Integer.parseInt(bom1.getQuantity()) + Integer.parseInt(bom.getQuantity()));

                        bom1.setQuantity(finalQuantity);

                        quotationBOMRepository.deleteById(bom.getId());

                        quotationBOMRepository.save(bom1);

                    } else {

                        quotationBOMRepository.save(bom);
                    }

                    size = quotationBOMRepository.findAllByQuotationIDAndPnameContains(quotationID, "Controller").size();

                    controllerPojo.setPname("Controller Module " + size);

                    quotationBOMRepository.save(controllerPojo);

                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping("/saveDataInQuotationBOM/{quotationID}")
    public String saveDataInQuotationBOM(@PathVariable String quotationID) {

        int GCount = 0;

        int fanCount = 0;

        int RGBCount = 0;

        int PCount = 0;

        int pointCount = 0;

        Quotation quotation = new Quotation();

        try {

            quotationBOMRepository.deleteAllByQuotationID(quotationID);

            quotation = quotationRepository.findById(quotationID);

            List<RoomBoards> list = roomBoardsRepository.findAllByQuotationID(quotationID);

            ListIterator iterator = list.listIterator();

            while (iterator.hasNext()) {

                ControllerPojo controllerPojo = new ControllerPojo();

                RoomBoards roomBoards = (RoomBoards) iterator.next();

                GCount = roomBoards.getLightPoint();

                fanCount = roomBoards.getFan();

                RGBCount = roomBoards.getRgb();

                PCount = roomBoards.getPower();

                pointCount = GCount + PCount;

                if (/*boardCount > 0 && */ !quotationBOMRepository.existsByQuotationIDAndRoomNameAndPnameContains(quotationID, roomBoards.getRoomName(), "Controller")) {

                    for (int i = 0; pointCount + fanCount + RGBCount != 0; i++) {

                        if (pointCount > 0 && i == 0 && !quotationBOMRepository.existsByQuotationIDAndRoomNameAndPnameContains(quotationID, roomBoards.getRoomName(), "Controller")) {

                            int controllerCount = 0;

                            if (PCount > 7) {

                                controllerCount = 7;

                                controllerPojo.setPower(7);

                                PCount = PCount - 7;

                                pointCount = pointCount - 7;

                            } else if (PCount <= 7) {

                                controllerCount = PCount;

                                controllerPojo.setPower(PCount);

                                pointCount = pointCount - PCount;

                                PCount = 0;
                            }

                            if (GCount + controllerCount <= 7) {

                                controllerCount = controllerCount + GCount;

                                controllerPojo.setGeneric(GCount);

                                pointCount = pointCount - GCount;

                                GCount = 0;

                            } else {

                                if (controllerCount < 7) {

                                    for (int p = 0; p <= 7; p++) {

                                        if (controllerCount < 7 && GCount > 0) {

                                            controllerCount++;

                                            controllerPojo.setGeneric(controllerPojo.getGeneric() + 1);

                                            pointCount--;

                                            GCount--;
                                        }
                                    }
                                }
                            }

                            if (controllerCount > 0) {

                                saveControllerDataInDatabase(controllerPojo, quotationID, roomBoards.getRoomName());
                            }

                        } else {

                            if (fanCount > 0) {

                                saveModuleDataInDatabase("Fan", fanCount, quotationID, roomBoards.getRoomName());

                                fanCount = 0;

                            }

                            if (GCount > 0 && GCount <= 3) {

                                saveModuleDataInDatabase("Generic", 1, quotationID, roomBoards.getRoomName());

                                pointCount = pointCount - GCount;

                                GCount = 0;
                            }

                            if (PCount > 0) {

                                saveModuleDataInDatabase("Power", PCount, quotationID, roomBoards.getRoomName());

                                pointCount = pointCount - PCount;

                                PCount = 0;
                            }

                            if (RGBCount > 0) {

                                saveModuleDataInDatabase("RGB", RGBCount, quotationID, roomBoards.getRoomName());

                                RGBCount = 0;
                            }
                        }
                    }
                } else {

                    for (int i = 0; pointCount + fanCount + RGBCount != 0; i++) {

                        if (pointCount > 3 || PCount >= 2 || GCount <= 3 && PCount >= 1 && GCount != 0) {

                            int controllerCount = 0;

                            if (PCount > 7) {

                                controllerCount = 7;

                                controllerPojo.setPower(7);

                                PCount = PCount - 7;

                                pointCount = pointCount - 7;

                            } else if (PCount <= 7) {

                                controllerCount = PCount;

                                controllerPojo.setPower(PCount);

                                pointCount = pointCount - PCount;

                                PCount = 0;
                            }

                            if (GCount + controllerCount <= 7) {

                                controllerCount = controllerCount + GCount;

                                controllerPojo.setGeneric(GCount);

                                pointCount = pointCount - GCount;

                                GCount = 0;

                            } else {

                                if (controllerCount < 7) {

                                    for (int p = 0; p <= 7; p++) {

                                        if (controllerCount < 7 && GCount > 0) {

                                            controllerCount++;

                                            controllerPojo.setGeneric(controllerPojo.getGeneric() + 1);

                                            pointCount--;

                                            GCount--;
                                        }
                                    }
                                }
                            }

                            if (controllerCount > 0) {

                                saveControllerDataInDatabase(controllerPojo, quotationID, roomBoards.getRoomName());
                            }

                        } else {

                            if (fanCount > 0) {

                                saveModuleDataInDatabase("Fan", fanCount, quotationID, roomBoards.getRoomName());

                                fanCount = 0;

                            }

                            if (GCount > 0 && GCount <= 3) {

                                saveModuleDataInDatabase("Generic", 1, quotationID, roomBoards.getRoomName());

                                pointCount = pointCount - GCount;

                                GCount = 0;
                            }

                            if (PCount > 0) {

                                saveModuleDataInDatabase("Power", PCount, quotationID, roomBoards.getRoomName());

                                pointCount = pointCount - PCount;

                                PCount = 0;
                            }

                            if (RGBCount > 0) {

                                saveModuleDataInDatabase("RGB", RGBCount, quotationID, roomBoards.getRoomName());

                                RGBCount = 0;
                            }
                        }
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/quotationBOMlist/" + quotation.getqNum() + "/" + quotationID;
    }

    @RequestMapping("/deleteRoomBoard/{deleteKey}/{quotationID}")
    public String deleteRoomBoard(@PathVariable String deleteKey,@PathVariable String quotationID) {

        try {

            roomBoardsRepository.deleteById(deleteKey);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/viewBoardsData/" + quotationID;
    }
}