package com.wify.erp.repository;

import com.wify.erp.NewPojo.RoomBoards;
import com.wify.erp.NewPojo.Supplier;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoomBoardsRepository extends MongoRepository<RoomBoards,Integer> {

    public List<RoomBoards> findByQuotationIDAndRoomName(String id, String name);

    public List<RoomBoards> findAllByQuotationID(String id);

    public String deleteAllByQuotationID(String id);

    public RoomBoards findById(String id);

    public String deleteById(String id);
}
