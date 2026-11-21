package org.paralisetu;

import static org.junit.jupiter.api.Assertions.*;
import java.math.BigDecimal;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;

class WorkflowTest {
    @Test void acceptanceReservesAndCancellationRestoresOnlyUntilPickup() {
        assertEquals(new Orders.Transition("ACCEPTED",1), Orders.transition("FARMER","REQUESTED","ACCEPT"));
        assertEquals(new Orders.Transition("CANCELLED",-1), Orders.transition("BUYER","ASSIGNED","CANCEL"));
        assertEquals(new Orders.Transition("CANCELLED",0), Orders.transition("BUYER","REQUESTED","CANCEL"));
        assertEquals(new Orders.Transition("DELIVERED",0), Orders.transition("LOGISTICS","PICKED_UP","DELIVER"));
        assertThrows(ApiProblem.class, () -> Orders.transition("BUYER","PICKED_UP","CANCEL"));
        assertThrows(ApiProblem.class, () -> Orders.transition("FARMER","ACCEPTED","ACCEPT"));
        assertThrows(ApiProblem.class, () -> Orders.transition("ADMIN","PICKED_UP","DELIVER"));
    }

    @Test void scoringExplainsDistrictAndPricePreferences() {
        var listing = Map.<String,Object>of("district","Ludhiana","price_per_kg",new BigDecimal("2.40"));
        var local = Insights.rank(listing," ludhiana ",new BigDecimal("2.40"));
        assertEquals(100, local.score());
        assertTrue(local.reasons().contains("Within budget (+10)"));
        assertEquals(75, Insights.rank(listing,"Patiala",new BigDecimal("2.39")).score());
        assertEquals(90, Insights.rank(listing,"Ludhiana",null).score());
    }

    @Test void sessionAuthorizationChecksTheServerSideRole() {
        var request = new MockHttpServletRequest();
        assertEquals(401, assertThrows(ApiProblem.class, () -> Accounts.require(request,"BUYER")).getStatusCode().value());
        request.getSession().setAttribute("user",new Accounts.User(3,"buyer@example.org","Buyer","BUYER"));
        assertEquals(3, Accounts.require(request,"BUYER").id());
        assertEquals(403, assertThrows(ApiProblem.class, () -> Accounts.require(request,"FARMER")).getStatusCode().value());
    }
}
